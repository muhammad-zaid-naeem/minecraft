# Phase 2: Retry plugins with correct slugs + Hangar + direct URLs
$ErrorActionPreference = 'Continue'
$ProgressPreference = 'SilentlyContinue'
$pluginsDir = "D:\server\plugins"
$dlDir      = "D:\server\setup\downloads"

function Download-Modrinth {
    param([string]$slug, [string]$displayName, [string]$gameVersion='1.21.1', [string]$loader='paper')
    Write-Host "[Modrinth] $displayName ($slug)..." -NoNewline
    try {
        $url = "https://api.modrinth.com/v2/project/$slug/version?game_versions=%5B%22$gameVersion%22%5D&loaders=%5B%22$loader%22%5D"
        $versions = Invoke-RestMethod -Uri $url -Method Get -TimeoutSec 30
        if (-not $versions -or $versions.Count -eq 0) {
            $versions = Invoke-RestMethod -Uri "https://api.modrinth.com/v2/project/$slug/version" -TimeoutSec 30
        }
        if (-not $versions -or $versions.Count -eq 0) { Write-Host " NO VERSIONS" -ForegroundColor Red; return }
        $latest = $versions[0]
        $primary = $latest.files | Where-Object { $_.primary } | Select-Object -First 1
        if (-not $primary) { $primary = $latest.files[0] }
        $outFile = Join-Path $dlDir $primary.filename
        Invoke-WebRequest -Uri $primary.url -OutFile $outFile -TimeoutSec 180
        Copy-Item -Path $outFile -Destination $pluginsDir -Force
        Write-Host " OK ($($primary.filename))" -ForegroundColor Green
    } catch {
        Write-Host " FAILED ($($_.Exception.Message))" -ForegroundColor Red
    }
}

function Download-Hangar {
    param([string]$author, [string]$project, [string]$displayName, [string]$platform='PAPER')
    Write-Host "[Hangar] $displayName ($author/$project)..." -NoNewline
    try {
        $vs = Invoke-RestMethod -Uri "https://hangar.papermc.io/api/v1/projects/$author/$project/versions?limit=1" -TimeoutSec 30 -Headers @{'User-Agent'='Setup'}
        $v = $vs.result[0]
        $vname = $v.name
        $dl = $v.downloads.$platform.downloadUrl
        if (-not $dl) {
            # Construct from CDN
            $dl = "https://hangarcdn.papermc.io/plugins/$author/$project/versions/$vname/$platform/$project-$vname.jar"
        }
        $fname = "$project-$vname.jar"
        $outFile = Join-Path $dlDir $fname
        Invoke-WebRequest -Uri $dl -OutFile $outFile -TimeoutSec 180 -Headers @{'User-Agent'='Setup'}
        Copy-Item -Path $outFile -Destination $pluginsDir -Force
        Write-Host " OK ($fname)" -ForegroundColor Green
    } catch {
        Write-Host " FAILED ($($_.Exception.Message))" -ForegroundColor Red
    }
}

function Download-Direct {
    param([string]$url, [string]$filename, [string]$displayName)
    Write-Host "[Direct] $displayName..." -NoNewline
    try {
        $outFile = Join-Path $dlDir $filename
        Invoke-WebRequest -Uri $url -OutFile $outFile -TimeoutSec 180 -Headers @{'User-Agent'='Setup'}
        Copy-Item -Path $outFile -Destination $pluginsDir -Force
        Write-Host " OK ($filename)" -ForegroundColor Green
    } catch {
        Write-Host " FAILED ($($_.Exception.Message))" -ForegroundColor Red
    }
}

Write-Host "=== Retries with correct slugs ===" -ForegroundColor Cyan
Download-Hangar  -author 'Archy' -project 'AuraSkills' -displayName 'AuraSkills'
Download-Modrinth -slug 'grimac' -displayName 'GrimAC'
Download-Modrinth -slug 'quests.classic' -displayName 'Quests (PikaMug)'
Download-Modrinth -slug 'combatlog+' -displayName 'CombatLog+'
Download-Modrinth -slug 'staff-plus' -displayName 'Staffplus'
Download-Modrinth -slug 'auction-house' -displayName 'Auction House'
Download-Modrinth -slug 'voting' -displayName 'Voting'
Download-Modrinth -slug 'economyshop' -displayName 'EconomyShop'

# EcoEnchants & eco — direct from Auxilor distribution via redirect (Modrinth has them under IDs)
# These are not on free Modrinth/Hangar; use polymart direct download
Download-Direct -url 'https://polymart.org/resource/download/2544' -filename 'eco.jar' -displayName 'eco (lib)'
Download-Direct -url 'https://polymart.org/resource/download/2554' -filename 'EcoEnchants.jar' -displayName 'EcoEnchants'

Write-Host "`n=== JAR INVENTORY ===" -ForegroundColor Cyan
Get-ChildItem $pluginsDir -Filter '*.jar' | Select-Object Name, @{N='SizeKB';E={[int]($_.Length/1KB)}} | Sort-Object Name | Format-Table -AutoSize
