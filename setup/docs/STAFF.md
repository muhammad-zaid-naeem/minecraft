# Staff

## Roster ranks

| Rank | Color | Who |
| --- | --- | --- |
| trial mod | `&2[TRIAL]` (variant of mod) | new staff in probation |
| mod | `&2[MOD]` | full moderator |
| admin | `&c[ADMIN]` | senior staff |
| owner | `&4&l[OWNER]` | server owner |

Promote / demote:

```
/lp user <name> parent set mod
/lp user <name> parent set admin
/lp user <name> parent remove mod
```

## Ticket System

The server does not ship with a dedicated ticket plugin. Two options:

### Option A: DiscordSRV-based tickets (recommended)

Install **DiscordTickets** (a DiscordSRV addon) or set up a custom Discord
ticket bot like Ticket Tool / Tickety. Players open tickets in Discord, and
staff resolve them there. In-game `/report <player>` still routes to the
staff-logs channel.

### Option B: TicketSystem in-game plugin

Install a Bukkit ticket plugin (e.g. **TicketSystem** or **CMI tickets**).
Players:

```
/ticket open <subject>
```

Staff:

```
/ticket list
/ticket claim <id>
/ticket reply <id> <message>
/ticket close <id>
```

## Reports

Built into EssentialsX:

```
/report <player> <reason>
```

Routes to:
1. All online staff in chat (yellow text).
2. Discord `#staff-logs` channel.
3. The reporting player gets confirmation.

Anti-abuse: cooldown 60s, max 5 reports per player per hour.

## Punishments (AdvancedBan)

Run from in-game or console:

| Command | Effect |
| --- | --- |
| `/kick <player> <reason>` | Disconnect immediately |
| `/mute <player> <reason>` | Permanent mute |
| `/tempmute <player> <time> <reason>` | e.g. `1h`, `1d`, `7d` |
| `/unmute <player>` | Remove mute |
| `/ban <player> <reason>` | Permanent ban |
| `/tempban <player> <time> <reason>` | Time-limited ban |
| `/unban <player>` | Unban |
| `/banip <ip-or-player> <reason>` | IP ban |
| `/warn <player> <reason>` | Add a warning |
| `/history <player>` | Show punishment history |

Time formats: `s`, `m`, `h`, `d`, `w`, `mo`, `y` (e.g. `30m`, `7d`).

## Warnings escalation

AdvancedBan supports auto-escalation in `Layouts.yml`. Recommended ladder:

| Warning # | Auto-action |
| --- | --- |
| 1 | warn only |
| 2 | warn only |
| 3 | tempmute 1h |
| 4 | tempmute 24h |
| 5 | tempban 24h |
| 7 | tempban 7d |
| 10 | permanent ban |

Sample `Layouts.yml` snippet:

```yaml
Layouts:
  WarnEscalation:
    1: WARN
    2: WARN
    3: TEMPMUTE 1h
    4: TEMPMUTE 24h
    5: TEMPBAN 24h
    7: TEMPBAN 7d
    10: BAN
```

## Staff Mode (StaffPlus)

Toggle: `/sm`. Gives staff:

- Vanish (`/v` or auto-on in staff mode).
- Compass: teleport to nearest player (right-click).
- Sword: examine inventory (left-click player).
- Book: freeze player (right-click).
- Chest: invsee.
- Spyglass: follow player invisibly.
- Paper: random teleport (auto-staff investigations).

Customise gadgets in `setup/configs/staffplus/config.yml`.

## Moderation Tools

| Action | Command |
| --- | --- |
| Inspect block placement / break | `/co i` then punch block |
| Lookup last 24h at location | `/co l t:24h r:5 u:#all` |
| Rollback griefer 1 hour | `/co rollback u:Griefer t:1h r:100` |
| Inspect inventory | `/invsee <player>` (admin) or `/examine` (mod via StaffPlus) |
| TP to player | `/tp <player>` (admin) or compass gadget (mod) |
| Freeze player | `/freeze <player>` (mod) |
| Vanish | `/v` |
| Inspect chest history | `/co i` + open chest |
| See chat in DMs | `/socialspy` |
| Watch commands | `/commandspy` |
| Manage clan | `/clan admin` |
| Force-stop boss | `/mm m killall <BossId>` |

## Full Logging

Two layers:

1. **CoreProtect-CE** - 90 days retention. Block, container, chat, command,
   sign logs. Database at `plugins/CoreProtect/database.db`.

2. **AdvancedBan history** - permanent. Stored in
   `plugins/AdvancedBan/data/history`. Browse:

```
/history <player>
```

Discord mirroring:

- AdvancedBan webhook -> `#staff-logs`.
- DiscordSRV staff-chat bridge -> staff chat in Discord.
- Console mirror -> `#console`.

## Staff workflow

### When a report comes in

1. Read `/report` chat or check `#staff-logs`.
2. `/co i` and inspect the area.
3. `/freeze <player>` if active grief.
4. Gather evidence (screenshots, command history `/spark profiler` if needed).
5. Apply punishment via AdvancedBan.
6. If grief: `/co rollback u:<player> t:<time> r:<radius>`.
7. Document the outcome in `#staff-logs` follow-up.

### When a player needs help

1. Acknowledge via `/sc <message to staff>`.
2. `/tp <player>` to them.
3. Use `/examine` to inspect their inventory if relevant.
4. Resolve, then return with `/back`.

### Rolling back a grief

```
/co inspect
# punch a destroyed block to see who broke it
/co rollback u:GrieferName t:6h r:100      # last 6h, 100-block radius
# verify
/co restore u:GrieferName t:6h r:100        # only if rollback was wrong
```

### Promoting / demoting staff

```
/lp user <name> parent set mod
/discord reload                              # sync Discord roles
```

## Staff conduct rules

- Never use `/op` - all staff actions via LuckPerms ranks.
- Never use `/eco give` for personal use. Audit log every economy admin
  command (CoreProtect logs commands).
- Never use `/gamemode creative` in survival worlds.
- Never use FAWE outside admin claims or staff-only worlds.
- Disclose to other staff when issuing a bantop-5-player permaban.
- Two-staff rule for tempbans > 7 days.

## Staff onboarding checklist

- [ ] Discord linked to MC account.
- [ ] LuckPerms group `mod` (or `admin`) applied.
- [ ] StaffPlus gadget tour walkthrough complete.
- [ ] CoreProtect lookup tested.
- [ ] AdvancedBan warn/mute test against a dummy account.
- [ ] DiscordSRV staff channel access verified.
- [ ] Read PERMISSIONS.md and this file.
