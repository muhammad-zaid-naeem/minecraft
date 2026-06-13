# Folder Structure

Visual map of the `D:\server\` directory.

```
D:\server\
|
|-- paper-1.21.1.jar              # Paper engine
|-- start.bat                     # Launcher (Aikar flags, 4GB heap)
|-- eula.txt                      # Must say eula=true
|-- server.properties             # Core server config (port, MOTD, pvp, gamemode)
|-- bukkit.yml                    # Spawn limits, autosave, aliases
|-- spigot.yml                    # World settings, view ranges, entity activation
|-- commands.yml                  # Command aliases
|-- help.yml                      # /help overrides
|-- permissions.yml               # File-based perms (mostly unused; LuckPerms does it)
|-- ops.json                      # Op list
|-- usercache.json                # Mojang name <-> UUID cache
|-- banned-players.json           # Vanilla bans (AdvancedBan supersedes this)
|-- banned-ips.json
|-- version_history.json
|
|-- config\                       # Paper-specific config
|   |-- paper-global.yml          # Server-wide paper settings
|   `-- paper-world-defaults.yml  # Anti-xray (engine-mode 2), chunk gen, etc.
|
|-- world\                        # Overworld save
|   |-- region\                   # Anvil region files
|   |-- entities\
|   |-- DIM-1\ (nether)           # (only if using same dir layout)
|   |-- DIM1\ (end)
|   |-- playerdata\
|   |-- advancements\
|   |-- stats\
|   |-- data\
|   |-- paper-world.yml           # Per-world Paper overrides
|   `-- level.dat
|-- world_nether\
|-- world_the_end\
|
|-- cache\                        # Mojang asset cache (mappings)
|-- libraries\                    # Paper-downloaded libs
|-- versions\                     # Paper bundled MC versions
|-- logs\                         # latest.log + gzipped history
|
|-- plugins\
|   |-- <jars>...                 # All plugin JARs (see PLUGIN_LIST.md)
|   |-- .paper-remapped\          # Auto-remapped legacy plugins
|   |
|   |-- Essentials\               # config.yml, kits.yml, userdata/, warps/
|   |-- LuckPerms\                # config.yml, libs/, luckperms-h2.mv.db
|   |-- Vault\
|   |-- GriefPrevention\          # config.yml, ClaimData/, messages.yml
|   |-- DiscordSRV\               # config.yml, messages.yml, linkedaccounts.json
|   |-- CoreProtect\              # config.yml, database.db
|   |-- AdvancedBan\              # config.yml, Layouts.yml, Reasons.yml, history/
|   |-- GrimAC\                   # config.yml, messages.yml, alerts.yml
|   |-- MythicMobs\
|   |   |-- Mobs\                 # *.yml mob definitions
|   |   |-- Items\                # *.yml item definitions
|   |   |-- Skills\               # *.yml skill definitions
|   |   |-- SpawnRules\
|   |   |-- Events\
|   |   `-- config.yml
|   |-- ExcellentCrates\
|   |   |-- crates\               # vote.yml daily.yml rare.yml epic.yml legendary.yml
|   |   |-- keys\
|   |   |-- menus\
|   |   `-- config.yml
|   |-- ZNPCsPlus\
|   |   |-- storage\
|   |   |   `-- npcs.yml          # All NPCs persist here
|   |   `-- config.yml
|   |-- DecentHolograms\
|   |   |-- holograms\            # Per-hologram .yml
|   |   `-- config.yml
|   |-- AuraSkills\               # config.yml, messages_en.yml, data/
|   |-- Quests\                   # config.yml, quests.yml, actions.yml, conditions.yml, data/
|   |-- QuickShop\                # config.yml, shops/, transactions.db
|   |-- EconomyShop\              # config.yml, shops/
|   |-- SimpleClans\              # config.yml, clans.db
|   |-- LifeStealZ\               # config.yml, data/
|   |-- PlayerParticles\          # config.yml, particles.yml
|   |-- StaffPlus\                # config.yml, menus.yml
|   |-- nuvotifier\               # config.yml, rsa/
|   |-- DriveBackupV2\            # config.yml, last-backup-state.json
|   |-- PlaceholderAPI\           # config.yml, expansions/
|   |-- FastAsyncWorldEdit\       # config.yml, schematics/
|   |-- ViaVersion\               # config.yml
|   |-- ViaBackwards\             # config.yml
|   |-- spark\                    # Perf profiler config
|   `-- bStats\                   # Anonymous metrics opt-in
|
|-- setup\                        # All non-runtime setup material (NOT loaded by Paper)
|   |
|   |-- downloads.ps1             # Helper script to fetch plugin JARs
|   |-- downloads_phase2.ps1
|   |-- downloads\                # Downloaded jars staging
|   |
|   |-- docs\                     # Markdown reference for ops/players/staff
|   |   |-- PLUGIN_LIST.md
|   |   |-- FOLDER_STRUCTURE.md   (this file)
|   |   |-- SETUP_GUIDE.md
|   |   |-- RANKS.md
|   |   |-- COMMANDS.md
|   |   |-- PERMISSIONS.md
|   |   |-- SPAWN_LAYOUT.md
|   |   |-- NPCS.md
|   |   |-- ECONOMY.md
|   |   |-- PROGRESSION.md
|   |   |-- PVP.md
|   |   |-- COMMUNITY.md
|   |   |-- COSMETICS.md
|   |   |-- CRATES.md
|   |   |-- DISCORD.md
|   |   |-- SECURITY.md
|   |   |-- STAFF.md
|   |   `-- EVENTS.md
|   |
|   |-- luckperms\
|   |   `-- ranks_setup.txt       # /lp commands to build the rank tree
|   |
|   |-- npcs\
|   |   `-- spawn_npcs.txt        # /npc commands to spawn 18 NPCs
|   |
|   |-- holograms\
|   |   `-- holograms_setup.txt   # /dh commands for spawn + leaderboard holograms
|   |
|   |-- crates\
|   |   `-- crates_setup.txt      # /crate commands to register 5 crates
|   |
|   |-- warps\
|   |   `-- warps_setup.txt       # /setwarp commands for spawn warps
|   |
|   |-- economy\
|   |   `-- economyshop_seed.txt  # /eshop commands to seed the server shop
|   |
|   `-- configs\                  # YAML config templates to drop into plugin dirs
|       |-- essentials\config.yml
|       |-- griefprevention\config.yml
|       |-- discordsrv\config.yml
|       |-- luckperms\config.yml
|       |-- quickshop\config.yml
|       |-- auraskills\config.yml
|       |-- quests\config.yml
|       |-- quests\quests.yml
|       |-- excellentcrates\crates\{vote,daily,rare,epic,legendary}.yml
|       |-- advancedban\config.yml
|       |-- staffplus\config.yml
|       |-- playerparticles\config.yml
|       |-- grimac\config.yml
|       |-- coreprotect\config.yml
|       |-- drivebackupv2\config.yml
|       |-- economyshop\config.yml
|       |-- znpcsplus\config.yml
|       |-- decentholograms\config.yml
|       `-- mythicmobs\
|           |-- Mobs\CustomMobs.yml
|           |-- Mobs\Bosses.yml
|           |-- Mobs\LootTables.yml
|           |-- Items\CustomItems.yml
|           |-- Items\CustomEnchants.yml
|           |-- Skills\BossSkills.yml
|           |-- SpawnRules\Spawners.yml
|           |-- Events\SeasonalEvents.yml
|           `-- README.md
|
|-- build_spawn.ps1               # Helper to paste the spawn schematic
|-- build_spawn.py
|-- paste_schem.py
|-- inspect_schem.py
`-- red_spawn.schem               # FAWE schematic for the spawn build
```

## Notes

- **Runtime vs setup**: Paper loads ONLY `plugins/`, `world*/`, `config/`,
  `cache/`, `libraries/`, `versions/`, and the root config files. Nothing under
  `setup/` is loaded at runtime - it is documentation + scripts only.
- **Backups**: DriveBackupV2 archives `world*/` and `plugins/` (excluding caches)
  every 6 hours by default. Configure it via
  `setup/configs/drivebackupv2/config.yml`.
- **Where to put a new plugin**: drop the `.jar` into `plugins/`, restart, then
  configure under the auto-created `plugins/<PluginName>/` directory.
