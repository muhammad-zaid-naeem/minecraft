# Plugin Auto-Downloader
# Sources: Modrinth API + GitHub releases. Skips plugins requiring SpigotMC CAPTCHA.
# Usage: powershell -ExecutionPolicy Bypass -File downloads.ps1

$ErrorActionPreference = 'Continue'
$ProgressPreference = 'SilentlyContinue'
$pluginsDir = "D:\server\plugins"
$dlDir      = "D:\server\setup\downloads"
$gameVersion = "1.21.1"
$loader = "paper"

if (-not (Test-Path $pluginsDir)) { New-Item -ItemType Directory -Path $pluginsDir | Out-Null }
if (-not (Test-Path $dlDir))      { New-Item -ItemType Directory -Path $dlDir      | Out-Null }

function Download-Modrinth {
    param([string]$slug, [string]$displayName)
    Write-Host "[Modrinth] $displayName ($slug)..." -NoNewline
    try {
        $url = "https://api.modrinth.com/v2/project/$slug/version?game_versions=%5B%22$gameVersion%22%5D&loaders=%5B%22$loader%22%5D"
        $versions = Invoke-RestMethod -Uri $url -Method Get -TimeoutSec 30
        if (-not $versions -or $versions.Count -eq 0) {
            # Fallback: any version, latest
            $url2 = "https://api.modrinth.com/v2/project/$slug/version"
            $versions = Invoke-RestMethod -Uri $url2 -Method Get -TimeoutSec 30
        }
        if (-not $versions -or $versions.Count -eq 0) { Write-Host " NO VERSIONS" -ForegroundColor Red; return }
        $latest = $versions[0]
        $primary = $latest.files | Where-Object { $_.primary } | Select-Object -First 1
        if (-not $primary) { $primary = $latest.files[0] }
        $outFile = Join-Path $dlDir $primary.filename
        Invoke-WebRequest -Uri $primary.url -OutFile $outFile -TimeoutSec 120
        Copy-Item -Path $outFile -Destination $pluginsDir -Force
        Write-Host " OK ($($primary.filename))" -ForegroundColor Green
    } catch {
        Write-Host " FAILED ($($_.Exception.Message))" -ForegroundColor Red
    }
}

function Download-GitHub {
    param([string]$repo, [string]$pattern, [string]$displayName)
    Write-Host "[GitHub] $displayName ($repo)..." -NoNewline
    try {
        $url = "https://api.github.com/repos/$repo/releases/latest"
        $rel = Invoke-RestMethod -Uri $url -Method Get -TimeoutSec 30 -Headers @{ 'User-Agent' = 'Claude-Setup' }
        $asset = $rel.assets | Where-Object { $_.name -match $pattern } | Select-Object -First 1
        if (-not $asset) { Write-Host " NO ASSET MATCH ($pattern)" -ForegroundColor Red; return }
        $outFile = Join-Path $dlDir $asset.name
        Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $outFile -TimeoutSec 180 -Headers @{ 'User-Agent' = 'Claude-Setup' }
        Copy-Item -Path $outFile -Destination $pluginsDir -Force
        Write-Host " OK ($($asset.name))" -ForegroundColor Green
    } catch {
        Write-Host " FAILED ($($_.Exception.Message))" -ForegroundColor Red
    }
}

function Download-Direct {
    param([string]$url, [string]$filename, [string]$displayName)
    Write-Host "[Direct] $displayName..." -NoNewline
    try {
        $outFile = Join-Path $dlDir $filename
        Invoke-WebRequest -Uri $url -OutFile $outFile -TimeoutSec 180 -Headers @{ 'User-Agent' = 'Claude-Setup' }
        Copy-Item -Path $outFile -Destination $pluginsDir -Force
        Write-Host " OK ($filename)" -ForegroundColor Green
    } catch {
        Write-Host " FAILED ($($_.Exception.Message))" -ForegroundColor Red
    }
}

Write-Host "`n=== PHASE A: Modrinth plugins ===" -ForegroundColor Cyan
Download-Modrinth -slug 'griefprevention' -displayName 'GriefPrevention'
Download-Modrinth -slug 'coreprotect' -displayName 'CoreProtect'
Download-Modrinth -slug 'placeholderapi' -displayName 'PlaceholderAPI'
Download-Modrinth -slug 'quickshop-hikari' -displayName 'QuickShop-Hikari'
Download-Modrinth -slug 'decentholograms' -displayName 'DecentHolograms'
Download-Modrinth -slug 'aurelium-skills' -displayName 'Aurelium AuraSkills'
Download-Modrinth -slug 'ecoenchants' -displayName 'EcoEnchants'
Download-Modrinth -slug 'eco' -displayName 'eco (EcoEnchants dep)'
Download-Modrinth -slug 'znpcsplus' -displayName 'ZNPCsPlus'
Download-Modrinth -slug 'mythicmobs' -displayName 'MythicMobs'
Download-Modrinth -slug 'combatlogx' -displayName 'CombatLogX'
Download-Modrinth -slug 'simpleclans' -displayName 'SimpleClans'
Download-Modrinth -slug 'discordsrv' -displayName 'DiscordSRV'
Download-Modrinth -slug 'playerparticles' -displayName 'PlayerParticles'
Download-Modrinth -slug 'auctionhouse' -displayName 'AuctionHouse'
Download-Modrinth -slug 'votingplugin' -displayName 'VotingPlugin'
Download-Modrinth -slug 'driveBackupV2' -displayName 'DriveBackupV2'
Download-Modrinth -slug 'staffplusplus' -displayName 'StaffPlus+'
Download-Modrinth -slug 'leaderheads' -displayName 'LeaderHeads'
Download-Modrinth -slug 'EconomyShopGUI' -displayName 'EconomyShopGUI'
Download-Modrinth -slug 'excellentcrates' -displayName 'ExcellentCrates'

Write-Host "`n=== PHASE B: GitHub releases ===" -ForegroundColor Cyan
Download-GitHub -repo 'MilkBowl/Vault' -pattern '^Vault\.jar$' -displayName 'Vault'
Download-GitHub -repo 'NuVotifier/NuVotifier' -pattern 'Votifier.*\.jar$' -displayName 'NuVotifier'
Download-GitHub -repo 'PikaMug/Quests' -pattern 'Quests-.*\.jar$' -displayName 'Quests (PikaMug)'
Download-GitHub -repo 'GrimAnticheat/Grim' -pattern 'Grim-.*\.jar$' -displayName 'GrimAC'
Download-GitHub -repo 'DevLeoko/AdvancedBan' -pattern 'AdvancedBan-.*\.jar$' -displayName 'AdvancedBan'

Write-Host "`n=== DONE ===" -ForegroundColor Cyan
Write-Host "Downloaded JARs are in: $dlDir"
Write-Host "Copied to plugins dir : $pluginsDir"
Get-ChildItem $pluginsDir -Filter '*.jar' | Select-Object Name, @{N='SizeKB';E={[int]($_.Length/1KB)}} | Format-Table -AutoSize
