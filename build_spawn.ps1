$ErrorActionPreference = "Stop"

function Invoke-RconCommand {
    param([string]$Password, [string]$Command)
    try {
        $client = New-Object System.Net.Sockets.TcpClient("127.0.0.1", 25575)
        $client.ReceiveTimeout = 5000
        $client.SendTimeout = 5000
        $stream = $client.GetStream()
        $bw = New-Object System.IO.BinaryWriter $stream
        $br = New-Object System.IO.BinaryReader $stream

        # Auth
        $authBytes = [System.Text.Encoding]::ASCII.GetBytes($Password)
        $bw.Write([int](4 + 4 + $authBytes.Length + 2))
        $bw.Write([int]1)
        $bw.Write([int]3)
        $bw.Write($authBytes)
        $bw.Write([byte]0); $bw.Write([byte]0)
        $bw.Flush()
        $size = $br.ReadInt32(); $id = $br.ReadInt32(); $type = $br.ReadInt32()
        $br.ReadBytes($size - 8) | Out-Null
        if ($id -eq -1) { throw "Auth failed" }

        # Command
        $cmdBytes = [System.Text.Encoding]::ASCII.GetBytes($Command)
        $bw.Write([int](4 + 4 + $cmdBytes.Length + 2))
        $bw.Write([int]2)
        $bw.Write([int]2)
        $bw.Write($cmdBytes)
        $bw.Write([byte]0); $bw.Write([byte]0)
        $bw.Flush()
        $size = $br.ReadInt32(); $id = $br.ReadInt32(); $type = $br.ReadInt32()
        $payloadBytes = $br.ReadBytes($size - 10)
        $br.ReadBytes(2) | Out-Null
        $resp = [System.Text.Encoding]::ASCII.GetString($payloadBytes)

        $client.Close()
        return $resp
    } catch {
        if ($client) { $client.Close() }
        return "ERROR: $_"
    }
}

$pwd = "lifesteal123"

$commands = @(
    "gamerule doDaylightCycle false",
    "gamerule doWeatherCycle false",
    "gamerule mobGriefing false",
    "time set day",
    "weather clear",
    "setworldspawn 0 101 0",
    "fill -27 95 -27 27 125 27 minecraft:air",
    "fill -25 95 -25 25 99 25 minecraft:deepslate",
    "fill -25 100 -25 25 100 25 minecraft:red_nether_bricks",
    "fill -23 100 -23 23 100 23 minecraft:crimson_planks",
    "fill -20 100 -20 20 100 20 minecraft:red_nether_bricks",
    "fill -15 100 -15 15 100 15 minecraft:nether_bricks",
    "fill -25 101 -25 25 108 -25 minecraft:red_nether_bricks",
    "fill -25 101 25 25 108 25 minecraft:red_nether_bricks",
    "fill -25 101 -25 -25 108 25 minecraft:red_nether_bricks",
    "fill 25 101 -25 25 108 25 minecraft:red_nether_bricks",
    "fill -2 101 -25 2 104 -25 minecraft:air",
    "fill -2 101 25 2 104 25 minecraft:air",
    "fill -25 101 -2 -25 104 2 minecraft:air",
    "fill 25 101 -2 25 104 2 minecraft:air",
    "fill -24 101 -24 -23 110 -23 minecraft:crying_obsidian",
    "fill 23 101 -24 24 110 -23 minecraft:crying_obsidian",
    "fill -24 101 23 -23 110 24 minecraft:crying_obsidian",
    "fill 23 101 23 24 110 24 minecraft:crying_obsidian",
    "fill -24 111 -24 -23 111 -23 minecraft:glowstone",
    "fill 23 111 -24 24 111 -23 minecraft:glowstone",
    "fill -24 111 23 -23 111 24 minecraft:glowstone",
    "fill 23 111 23 24 111 24 minecraft:glowstone",
    "fill -25 109 -25 25 109 25 minecraft:red_stained_glass",
    "fill -3 100 -3 3 100 3 minecraft:netherite_block",
    "fill -2 101 -2 2 101 2 minecraft:iron_block",
    "fill -1 102 -1 1 102 1 minecraft:iron_block",
    "setblock 0 103 0 minecraft:beacon",
    "fill -3 100 -10 -1 100 -8 minecraft:red_wool",
    "fill 1 100 -10 3 100 -8 minecraft:red_wool",
    "fill -3 100 -7 3 100 -6 minecraft:red_wool",
    "fill -2 100 -5 2 100 -5 minecraft:red_wool",
    "fill -1 100 -4 1 100 -4 minecraft:red_wool",
    "setblock 0 100 -3 minecraft:red_wool",
    "fill -27 99 -27 27 99 -26 minecraft:lava",
    "fill -27 99 26 27 99 27 minecraft:lava",
    "fill -27 99 -27 -26 99 27 minecraft:lava",
    "fill 26 99 -27 27 99 27 minecraft:lava",
    "setblock 0 103 -25 minecraft:red_wall_banner[facing=south]",
    "setblock 0 103 25 minecraft:red_wall_banner[facing=north]",
    "setblock -25 103 0 minecraft:red_wall_banner[facing=east]",
    "setblock 25 103 0 minecraft:red_wall_banner[facing=west]",
    "setblock -22 101 -22 minecraft:soul_torch",
    "setblock 22 101 -22 minecraft:soul_torch",
    "setblock -22 101 22 minecraft:soul_torch",
    "setblock 22 101 22 minecraft:soul_torch",
    "setworldspawn 0 101 0",
    "say LifeSteal SMP spawn arena built!"
)

$total = $commands.Count
$i = 0
foreach ($cmd in $commands) {
    $i++
    $resp = Invoke-RconCommand -Password $pwd -Command $cmd
    Write-Output "[$i/$total] $cmd -> $($resp.Trim())"
}

Write-Output ""
Write-Output "DONE - Spawn arena built at (0, 101, 0)!"
