# Security

## Anti-Cheat (GrimAC)

Plugin: **GrimAC 2.3.74**.

| Check | Default | Notes |
| --- | --- | --- |
| Movement (Phase / Jesus / Speed / Fly) | enabled | server-authoritative |
| Combat (KillAura / Reach / AutoClicker) | enabled | tightened on PvP world |
| Scaffold | enabled | exempt for `grim.bypass.scaffold` |
| FastBreak | enabled | exempt creative |
| Timer / Tick speed | enabled | |
| Async checks | enabled | low CPU |

Staff should have `grim.alerts` (warns staff in chat) but NOT `grim.bypass.*`.
Set max ping for kicks at 400 ms (`config.yml -> max-ping`).

Tune in `plugins/GrimAC/config.yml` (start with the template at
`setup/configs/grimac/config.yml`).

## Anti-XRay

Paper has native anti-xray. Enabled in `config/paper-world-defaults.yml`
(`anticheat.anti-xray.enabled: true`, `engine-mode: 2`). Engine-mode 2 is the
strong mode - it replaces the actual block IDs that the client sees.

Hidden blocks (the default Paper list applies; expand if needed):

- diamond_ore / deepslate_diamond_ore
- ancient_debris
- emerald_ore / deepslate_emerald_ore
- gold_ore / deepslate_gold_ore
- raw_*_block
- iron_ore / deepslate_iron_ore
- coal_ore (optional)

Replacement blocks: stone, deepslate, oak_planks (in nether: netherrack).

Engine-mode 2 has a measurable CPU cost - watch `/spark profiler` if you
have <2GB heap.

## Anti-Bot Protection

The server runs `online-mode=false` (cracked), which makes it an attractive
target for bot floods. Required mitigations:

1. **Install LimboAuth or NLogin** (see PLUGIN_LIST.md). Routes new joins to
   a limbo world until they `/login`. Filters bots that don't respond to
   chat.
2. **Paper packet limiter** (`config/paper-global.yml`):
   - `packet-limiter.all-packets.max-packet-rate: 500.0`
   - `packet-limiter.all-packets.interval: 7.0`
   - kick action enabled (already default).
3. **Max joins per tick: 5** (already set in `paper-global.yml`).
4. **Connection throttle** (`bukkit.yml -> connection-throttle: 4000`).
5. **Whitelist mode** during launch first 24-48h:
   ```
   /whitelist on
   /whitelist add <staff>
   ```
6. **IP rate limit** via firewall (`iptables` or Windows Defender Firewall
   advanced rules) - max 3 connections per IP per 10 seconds.
7. **Cloudflare Spectrum or TCPShield** (recommended paid mitigation for
   public servers).

## Backup System (DriveBackupV2)

Plugin: **DriveBackupV2**.

| Setting | Default |
| --- | --- |
| Schedule | every 6 hours |
| Retention | 14 backups (84 hours of history) |
| Backup paths | `world/`, `world_nether/`, `world_the_end/`, `plugins/` |
| Excluded | `cache/`, `libraries/`, `versions/`, `logs/`, large *.mca temp |
| Compression | zip |
| Destination | Google Drive (or local-only) |

Link Google Drive:

```
/drivebackup linkaccount googledrive
```

Test:

```
/drivebackup nextbackup
/drivebackup forcebackup
```

Restore a backup:

```
/drivebackup restore <backupname>
```

Or restore manually: download the zip from Drive, unzip into a fresh server
folder, restart.

## CoreProtect (logging + rollback)

Plugin: **CoreProtect-CE 23.2**.

Logs:

- Block place / break / interact
- Container open / take / put
- Chat
- Commands
- Sign edits

Retention: 90 days (purge older with `/co purge t:90d`).

Common forensics queries:

```
/co inspect                                      # toggle inspector
/co lookup u:player1 t:1d r:50                   # who did what at x,y,z radius 50
/co lookup b:#diamond a:break t:7d                # who mined diamond in 7d
/co lookup u:player2 t:24h a:container r:30       # container access
```

Rollback grief:

```
/co rollback u:GrieferName t:1h r:100             # last hour, 100-block radius
/co restore u:GrieferName t:1h r:100              # undo the rollback
```

Database: `plugins/CoreProtect/database.db`. Back up alongside the world.

## File / process hardening

| Item | Action |
| --- | --- |
| RCON password | CHANGE the default `lifesteal123` in `server.properties` |
| RCON port | bind to `127.0.0.1` only, or firewall to staff IPs |
| `ops.json` | only the actual server owner. Use LuckPerms for everyone else. |
| `eula.txt` | confirm `eula=true` once - never expose to internet write |
| File permissions | restrict `server.properties`, `*.yml`, `world/` to the server user only |
| Java heap | set `-Xmx4G -Xms4G` to prevent runaway GC - already in `start.bat` |
| OOM detection | enable `XX:+CrashOnOutOfMemoryError` if you want auto-restart on OOM |
| Watchdog | `paper-global.yml -> watchdog` already configured (early-warning at 10s) |

## Chat protection

- AdvancedBan chat filter list (`plugins/AdvancedBan/messages.yml -> Filter`).
- EssentialsX antispam: max-msg-per-sec 0.66, max-caps 50%.
- Per-rank `chat.color` / `chat.format` perms to gate hex codes for paid ranks.

## Security checklist before going live

- [ ] RCON password changed.
- [ ] LimboAuth (or NLogin) installed and configured.
- [ ] Anti-XRay enabled, engine-mode 2.
- [ ] DriveBackupV2 linked to Google Drive AND a manual backup taken.
- [ ] CoreProtect tested with `/co inspect` + lookup.
- [ ] Staff ranks granted only via LuckPerms (no `ops.json` for non-owners).
- [ ] Whitelist on for launch 24h.
- [ ] Firewall rule: max 3 conn/IP/10s; only allow MC port 25565.
- [ ] DDoS mitigation upstream (TCPShield / Cloudflare) if internet-facing.
- [ ] AdvancedBan webhook to Discord `#staff-logs`.
- [ ] Server crash auto-restart in `start.bat` (already in place).
