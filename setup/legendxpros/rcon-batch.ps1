# Batch Source RCON client: sends every non-empty, non-# line of a file.
# Usage: powershell -File rcon-batch.ps1 "path\to\commands.txt"
param([Parameter(Mandatory=$true)][string]$File)

$RconHost = "127.0.0.1"; $RconPort = 25575; $RconPass = "lifesteal123"

function Send-Packet($stream, [int]$id, [int]$type, [string]$body) {
    $b = [System.Text.Encoding]::UTF8.GetBytes($body)
    $ms = New-Object System.IO.MemoryStream
    $bw = New-Object System.IO.BinaryWriter($ms)
    $bw.Write([int](4 + 4 + $b.Length + 2)); $bw.Write([int]$id); $bw.Write([int]$type)
    $bw.Write($b); $bw.Write([byte]0); $bw.Write([byte]0); $bw.Flush()
    $d = $ms.ToArray(); $stream.Write($d, 0, $d.Length); $stream.Flush()
}
function Read-Packet($stream) {
    $lb = New-Object byte[] 4
    if ($stream.Read($lb,0,4) -lt 4) { return $null }
    $len = [BitConverter]::ToInt32($lb,0)
    $buf = New-Object byte[] $len; $off = 0
    while ($off -lt $len) { $n = $stream.Read($buf,$off,$len-$off); if ($n -le 0){break}; $off += $n }
    return [System.Text.Encoding]::UTF8.GetString($buf, 8, $len-8-2)
}

$client = New-Object System.Net.Sockets.TcpClient
$client.Connect($RconHost, $RconPort)
$stream = $client.GetStream()
Send-Packet $stream 1 3 $RconPass
if ((Read-Packet $stream) -eq $null) { Write-Output "AUTH FAILED"; exit 1 }
Write-Output "AUTH OK"

$id = 100; $count = 0; $fail = 0
foreach ($line in Get-Content $File) {
    $cmd = $line.Trim()
    if ($cmd -eq "" -or $cmd.StartsWith("#")) { continue }
    $id++; $count++
    Send-Packet $stream $id 2 $cmd
    Start-Sleep -Milliseconds 130
    $out = ""
    while ($stream.DataAvailable) { $out += (Read-Packet $stream); Start-Sleep -Milliseconds 20 }
    $out = ($out -replace "`r"," " -replace "`n"," ").Trim()
    if ($out -match "(?i)error|unknown command|no permission|does not exist|already") { $fail++; Write-Output ("[WARN] $cmd  ->  $out") }
    else { Write-Output ("[OK]   $cmd") }
}
$stream.Close(); $client.Close()
Write-Output "----------------------------------------"
Write-Output "Sent $count commands. Flagged: $fail (review WARN lines above)."
