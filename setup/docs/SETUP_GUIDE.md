# Setup Guide

End-to-end walkthrough to take this directory from "Paper jar + plugins" to a
fully wired production survival server.

Estimated time: 90 minutes for a first run, 20 minutes for an experienced op.

---

## 0. Prerequisites

- Java 21 (JDK or JRE). Verify with `java -version`.
- 4 GB RAM minimum, 8 GB recommended.
- Windows 10/11 (this guide uses `start.bat`). Linux equivalent: `start.sh`.
- A Discord server + bot (for DiscordSRV).
- A Google account (for DriveBackupV2 - optional).
- Voting site accounts: minecraft-mp.com, planetminecraft.com,
  minecraftservers.org, topg.org (for VotingPlugin - optional).

## 1. First boot

```
1. cd D:\server
2. start.bat
3. The server prints "Done (Xs)!" then loads the world.
4. Type "stop" in the console.
```

This generates `world/`, `world_nether/`, `world_the_end/`, every
`plugins/<plugin>/` directory and all default config files.

## 2. Configure server core

Edit these and restart after each one:

- `server.properties` - already tuned (max-players=100, spawn-protection=30,
  view-distance=8, simulation-distance=6, RCON enabled).
- `bukkit.yml` - already tuned (lower spawn-limits to reduce mob lag).
- `spigot.yml` - keep defaults; verify `restart-on-crash: true`.
- `config/paper-global.yml` - keep defaults.
- `config/paper-world-defaults.yml` - already tuned (`anti-xray.engine-mode: 2`).

Do NOT change `online-mode` unless you also remove the cracked-server MOTD and
plan to install LimboAuth.

## 3. Install / verify plugins

All required plugins are listed in `setup/docs/PLUGIN_LIST.md`. Verify each is
in `D:\server\plugins\`:

```
ls D:\server\plugins\
```

Drop any missing JAR in and restart. After restart, every plugin should have a
folder under `plugins/<PluginName>/`.

## 4. Copy plugin config templates

For each plugin you want to override the default config of, copy the file in
`setup/configs/<plugin>/config.yml` into the destination listed in that file's
`# DESTINATION:` header comment, replacing the auto-generated config.

Typically:

```
copy setup\configs\essentials\config.yml         plugins\Essentials\config.yml
copy setup\configs\griefprevention\config.yml    plugins\GriefPrevention\config.yml
copy setup\configs\quickshop\config.yml          plugins\QuickShop\config.yml
copy setup\configs\auraskills\config.yml         plugins\AuraSkills\config.yml
copy setup\configs\quests\config.yml             plugins\Quests\config.yml
copy setup\configs\quests\quests.yml             plugins\Quests\quests.yml
copy setup\configs\advancedban\config.yml        plugins\AdvancedBan\config.yml
copy setup\configs\staffplus\config.yml          plugins\StaffPlus\config.yml
copy setup\configs\playerparticles\config.yml    plugins\PlayerParticles\config.yml
copy setup\configs\grimac\config.yml             plugins\GrimAC\config.yml
copy setup\configs\coreprotect\config.yml        plugins\CoreProtect\config.yml
copy setup\configs\drivebackupv2\config.yml      plugins\DriveBackupV2\config.yml
copy setup\configs\economyshop\config.yml        plugins\EconomyShop\config.yml
copy setup\configs\znpcsplus\config.yml          plugins\ZNPCsPlus\config.yml
copy setup\configs\decentholograms\config.yml    plugins\DecentHolograms\config.yml
copy setup\configs\luckperms\config.yml          plugins\LuckPerms\config.yml
copy setup\configs\tab\config.yml                plugins\TAB\config\config.yml
copy setup\configs\tab\groups.yml                plugins\TAB\config\groups.yml
copy setup\configs\tab\animations.yml            plugins\TAB\config\animations.yml
```

Restart after copying.

## 5. Load LuckPerms ranks

Open the in-game console (or RCON), then paste the lines from
`setup/luckperms/ranks_setup.txt` ONE LINE AT A TIME, skipping comment lines.
This creates the 7-rank ladder: `default` -> `vip` -> `mvp` -> `elite` ->
`mod` -> `admin` -> `owner`.

Verify:

```
lp listgroups
lp group owner info
```

Promote yourself:

```
lp user <yourname> parent set owner
```

## 6. Set up Vault economy

EssentialsX is your economy provider. Verify with:

```
plugin Vault
```

You should see `Economy: Essentials`. If not, ensure EssentialsX loaded first
and re-run `/vault-info`.

Starting balance ($500) is set in `setup/configs/essentials/config.yml`.

## 7. Land claims (GriefPrevention)

Test by placing a chest in survival - GP should auto-claim a 4-block radius.

Important config in `setup/configs/griefprevention/config.yml`:
- `ClaimBlocks.Initial: 100`
- `ClaimBlocks.PerHour: 120`
- `Claims.AutomaticClaimsForNewPlayersRadius: 4`

## 8. Build / paste the spawn

The schematic `D:\server\red_spawn.schem` is provided. Paste it at spawn:

```
/fawe paste red_spawn.schem
```

Or use the helper script `build_spawn.ps1` from PowerShell. Then verify
landmarks at the coordinates listed in `setup/docs/SPAWN_LAYOUT.md`.

Set the spawn point:

```
/setworldspawn 0 101 0
/spawn        (test it)
```

## 9. Warps

Paste `setup/warps/warps_setup.txt` into the console - it teleports you and
sets each warp at the correct coordinates.

## 10. NPCs (ZNPCsPlus)

Paste the lines from `setup/npcs/spawn_npcs.txt` into the console. This
creates 18 NPCs with skins, holograms, and click commands. Verify:

```
npc list
npc near 50
```

Reposition any NPC by standing where you want it and running `/npc move <id>`.

## 11. Holograms (DecentHolograms)

Paste the lines from `setup/holograms/holograms_setup.txt`. This creates the
welcome hologram and four leaderboard holograms (top money, top kills, top
level, top votes). Verify:

```
dh list
```

## 12. Crates (ExcellentCrates)

Copy each crate definition into the plugin directory:

```
copy setup\configs\excellentcrates\crates\*.yml  plugins\ExcellentCrates\crates\
```

Reload: `/crate reload`. Run the registration script:

```
... paste setup\crates\crates_setup.txt one line at a time
```

Test a crate:

```
crate key give <yourname> vote 5
```

Then right-click the vote crate block at spawn.

## 13. Server shop seed

```
... paste setup\economy\economyshop_seed.txt one line at a time
```

Verify with `/shop`.

## 14. Quests + Battle Pass

Copy `setup/configs/quests/quests.yml` into `plugins/Quests/quests.yml`. Restart
the Quests plugin: `/quests reload`. Verify with `/quests gui`.

## 15. Custom mobs / bosses (MythicMobs)

Copy the entire MythicMobs config tree:

```
copy setup\configs\mythicmobs\Mobs\*.yml         plugins\MythicMobs\Mobs\
copy setup\configs\mythicmobs\Items\*.yml        plugins\MythicMobs\Items\
copy setup\configs\mythicmobs\Skills\*.yml       plugins\MythicMobs\Skills\
copy setup\configs\mythicmobs\SpawnRules\*.yml   plugins\MythicMobs\SpawnRules\
copy setup\configs\mythicmobs\Events\*.yml       plugins\MythicMobs\Mobs\
```

Reload: `/mm reload`. Test by spawning a boss:

```
mm m spawn PyroLord 1 ~ ~ ~
```

## 16. DiscordSRV

1. Create a Discord bot at https://discord.com/developers and copy its token.
2. Invite the bot to your server with the `Send Messages`, `Manage Channels`,
   `Read Message History` and `Manage Roles` permissions.
3. Edit `plugins/DiscordSRV/config.yml`:
   - `BotToken: <paste here>`
   - `Channels:` map - set each Discord channel ID to its game channel.
   - `GroupRoleSynchronizationGroupsAndRolesToSync:` - map LuckPerms group
     names to Discord role IDs.
4. Restart the server. The bot should come online and link chat.
5. In-game: `/discord link` to test account linking.

## 17. Voting (nuvotifier + VotingPlugin)

1. Set up votifier listener on TCP `:8192` (already enabled by nuvotifier).
2. Copy the votifier public key from `plugins/Votifier/rsa/public.key` and paste
   it into each voting site's settings (minecraft-mp.com etc.).
3. Install VotingPlugin (see PLUGIN_LIST.md "Recommended"), then configure
   reward triggers in `plugins/VotingPlugin/Rewards/`. Suggested: $50 + 1
   vote_key per vote.

## 18. Backups (DriveBackupV2)

```
/drivebackup linkaccount googledrive
```

Follow the OAuth flow. The default schedule (every 6 hours, 14 retained) is
already in the template config.

## 18b. Tab list + Scoreboard (TAB v6.0.3)

TAB is already installed at `plugins/TAB-6.0.3.jar`. After the server has
booted once (so TAB generates its default `plugins/TAB/config/` folder),
copy the templates per step 4 above, then:

```
/papi ecloud download Vault
/papi ecloud download Player
/papi ecloud download Statistic
/papi reload
/tab reload
```

Verify:

- Open `Tab` key in-game - header/footer + player list with prefixes.
- `/sb` toggles the sidebar scoreboard. Walk into nether / end / pvp world
  to see the world-specific board swap in.
- Full reference: `setup/docs/TAB_SCOREBOARD.md`.

## 19. Anti-cheat (GrimAC)

Defaults are sane. Ensure staff have the `grim.exempt` permission OFF and the
`grim.alerts` permission ON. Tune in `plugins/GrimAC/config.yml`.

## 20. Test checklist

| Feature | Test |
| --- | --- |
| Connect | Join from a 1.21.x client - should land at spawn (0,101,0) |
| Multi-version | Join from a 1.8.9 client via ViaBackwards |
| Spawn protection | Try to break a block at spawn - should fail |
| Chat | Type a message - prefix should appear in front of name |
| Rank | `/lp user <you> info` - should show group `owner` (or assigned rank) |
| Land claim | Place a chest - GP should auto-claim |
| Economy | `/balance` shows $500; `/pay <player> 50` works |
| Shop | `/shop` opens GUI |
| Player shop | Place a chest, hold an item, left-click chest with `/qs create` |
| Crates | `/crate menu` shows 5 crates |
| Quests | `/quests gui` shows daily quests |
| Skills | Mine stone - chat shows `+0.2 XP Mining` |
| Clans | `/clan create XYZ "tag"` |
| NPCs | Right-click each spawn NPC - command should run |
| Holograms | Welcome and leaderboard text visible |
| Tab list | Press Tab key - header, sorted rows, ping suffix all show |
| Scoreboard | `/sb` opens sidebar with balance, level, K/D, clan, hearts |
| Anti-cheat | Use a hacked client briefly (test env only) - GrimAC kicks |
| PvP | Combat tag appears, `/spawn` is blocked during combat |
| LifeSteal | Kill a player - both hearts update (+1 / -1) |
| Boss | `mm m spawn PyroLord 1 ~ ~ ~` then fight it |
| Discord | Bot online, /discord link works, chat bridges |
| Backup | `/drivebackup nextbackup` shows a scheduled time |

## 21. Going live

- Set a strong RCON password in `server.properties` (default `lifesteal123`
  must be changed).
- Whitelist the server during your first 24 hours (`/whitelist on` +
  `/whitelist add <staff>`).
- Open `server.properties` `motd` to your final tagline.
- Open port 25565 on your firewall / router.
- Add your IP to DNS (A or SRV record).
- Monitor `logs/latest.log` via `tail -f` or RCON.

## 22. Maintenance

| Task | Command / Action |
| --- | --- |
| Restart | `stop` in console (the bat loop restarts you) |
| View live log | `Get-Content -Wait logs\latest.log` |
| Inspect grief | `/co i` then punch a block |
| Rollback player damage | `/co rollback u:<player> t:24h r:50` |
| Restore from backup | `/drivebackup restore <name>` |
| Reload all plugins (DON'T in prod) | `restart` instead |
| Check TPS | `/spark tps` or `/tps` (Paper) |
| Profile lag | `/spark profiler` then `/spark profiler --stop` |
| Free memory | `/spark heapsummary` |
| Promote user | `/lp user <name> parent set <rank>` |
| Ban | `/ban <player> <reason>` |
| Tempban | `/tempban <player> 7d <reason>` |
| Warn | `/warn <player> <reason>` (escalates at 3/5/10) |

---

Done. Tab back to PLUGIN_LIST.md, RANKS.md and the per-feature docs from here.
