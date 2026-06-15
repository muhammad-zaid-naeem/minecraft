# Minimal Source RCON client for the LEGENDxPROs server.
# Usage: powershell -File rcon.ps1 "<command>"
param([string]$Command = "list")

$RconHost = "127.0.0.1"
$RconPort = 25575
$RconPass = "lifesteal123"

function Send-Packet([System.Net.Sockets.NetworkStream]$stream, [int]$id, [int]$type, [string]$body) {
    $bodyBytes = [System.Text.Encoding]::ASCII.GetBytes($body)
    $len = 4 + 4 + $bodyBytes.Length + 2
    $ms = New-Object System.IO.MemoryStream
    $bw = New-Object System.IO.BinaryWriter($ms)
    $bw.Write([int]$len)
    $bw.Write([int]$id)
    $bw.Write([int]$type)
    $bw.Write($bodyBytes)
    $bw.Write([byte]0); $bw.Write([byte]0)
    $bw.Flush()
    $data = $ms.ToArray()
    $stream.Write($data, 0, $data.Length)
    $stream.Flush()
}

function Read-Packet([System.Net.Sockets.NetworkStream]$stream) {
    $lenBuf = New-Object byte[] 4
    $read = $stream.Read($lenBuf, 0, 4)
    if ($read -lt 4) { return $null }
    $len = [BitConverter]::ToInt32($lenBuf, 0)
    $buf = New-Object byte[] $len
    $off = 0
    while ($off -lt $len) {
        $n = $stream.Read($buf, $off, $len - $off)
        if ($n -le 0) { break }
        $off += $n
    }
    $id   = [BitConverter]::ToInt32($buf, 0)
    $body = [System.Text.Encoding]::ASCII.GetString($buf, 8, $len - 8 - 2)
    return [pscustomobject]@{ Id = $id; Body = $body }
}

try {
    $client = New-Object System.Net.Sockets.TcpClient
    $client.Connect($RconHost, $RconPort)
    $stream = $client.GetStream()

    Send-Packet $stream 1 3 $RconPass   # auth
    $auth = Read-Packet $stream
    if ($auth.Id -eq -1) { Write-Output "AUTH FAILED"; exit 1 }
    Write-Output "AUTH OK"

    Send-Packet $stream 2 2 $Command    # exec command
    # Poll up to ~3s for async replies (LuckPerms responds late)
    $resp = ""; $waited = 0
    while ($waited -lt 3000) {
        if ($stream.DataAvailable) {
            $p = Read-Packet $stream; if ($p) { $resp += $p.Body }
        } else { Start-Sleep -Milliseconds 100; $waited += 100 }
    }
    Write-Output ("RESPONSE:`n" + $resp)

    $stream.Close(); $client.Close()
} catch {
    Write-Output ("RCON ERROR: " + $_.Exception.Message)
    exit 1
}
