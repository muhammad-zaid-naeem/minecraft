# Run from a regular PowerShell window in D:\server\:
#   powershell -ExecutionPolicy Bypass -File setup\wild\create_wild.ps1
#
# Sends `mv create wild normal` and verification commands via RCON.

function Send-Rcon { param([string]$Cmd)
  try {
    $tc = New-Object System.Net.Sockets.TcpClient
    $tc.Connect('127.0.0.1', 25575)
    $s = $tc.GetStream()
    $body = [System.Text.Encoding]::ASCII.GetBytes('lifesteal123')
    $buf = New-Object System.IO.MemoryStream
    $bw = New-Object System.IO.BinaryWriter($buf)
    $bw.Write([int](10 + $body.Length)); $bw.Write([int]1); $bw.Write([int]3)
    $bw.Write($body); $bw.Write([byte]0); $bw.Write([byte]0); $bw.Flush()
    $p = $buf.ToArray(); $s.Write($p,0,$p.Length)
    $h = New-Object 'byte[]' 4; [void]$s.Read($h,0,4)
    $sz = [BitConverter]::ToInt32($h,0)
    $r = New-Object 'byte[]' $sz; $got=0
    while ($got -lt $sz) { $got += $s.Read($r,$got,$sz-$got) }
    $body2 = [System.Text.Encoding]::ASCII.GetBytes($Cmd)
    $buf2 = New-Object System.IO.MemoryStream
    $bw2 = New-Object System.IO.BinaryWriter($buf2)
    $bw2.Write([int](10 + $body2.Length)); $bw2.Write([int]2); $bw2.Write([int]2)
    $bw2.Write($body2); $bw2.Write([byte]0); $bw2.Write([byte]0); $bw2.Flush()
    $p2 = $buf2.ToArray(); $s.Write($p2,0,$p2.Length)
    $h2 = New-Object 'byte[]' 4; [void]$s.Read($h2,0,4)
    $sz2 = [BitConverter]::ToInt32($h2,0)
    $r2 = New-Object 'byte[]' $sz2; $got2=0
    while ($got2 -lt $sz2) { $got2 += $s.Read($r2,$got2,$sz2-$got2) }
    $tc.Close()
    return [System.Text.Encoding]::ASCII.GetString($r2, 8, $sz2-10)
  } catch { return "ERR: $($_.Exception.Message)" }
}

Write-Host '>>> mv list (before)' -ForegroundColor Cyan
Send-Rcon 'mv list'

Write-Host '>>> mv create wild normal (may take 30-90s)' -ForegroundColor Yellow
Send-Rcon 'mv create wild normal'

Start-Sleep -Seconds 8

Write-Host '>>> mv modify set pvp true wild' -ForegroundColor Cyan
Send-Rcon 'mv modify set pvp true wild'
Send-Rcon 'mv modify set difficulty hard wild'
Send-Rcon 'mv modify set portalForm NONE wild'
Send-Rcon 'mv modify set respawnWorld world wild'
Send-Rcon 'mv modify set alias &6Wild wild'
Send-Rcon 'mv modify set keepSpawnInMemory false wild'

Write-Host '>>> worldborder' -ForegroundColor Cyan
Send-Rcon 'worldborder set 10000 wild'
Send-Rcon 'worldborder center 0 0 wild'

Write-Host '>>> mv list (after)' -ForegroundColor Green
Send-Rcon 'mv list'

Write-Host '>>> mv info wild' -ForegroundColor Green
Send-Rcon 'mv info wild'

Write-Host 'Done.' -ForegroundColor Green
