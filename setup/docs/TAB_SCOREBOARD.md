# Tab List + Scoreboard (TAB v6.0.3)

LifeSteal SMP uses **TAB by NEZNAMY** for tab list, sidebar scoreboard,
nametags above heads, and bossbar - one plugin handles everything.

- Plugin: **TAB v6.0.3** (Vanilla / Bukkit build).
- Already downloaded to: `D:\server\plugins\TAB-6.0.3.jar`.
- Also kept in: `D:\server\setup\downloads\TAB-6.0.3.jar`.
- Requires: PlaceholderAPI (already installed) + Vault expansion + Player
  expansion + Statistic expansion. Install with:

```
/papi ecloud download Vault
/papi ecloud download Player
/papi ecloud download Statistic
/papi reload
```

Optional for richer placeholders:

```
/papi ecloud download ServerOnline
/papi ecloud download SimpleClans
/papi ecloud download Math
```

## Install

1. **TAB jar is already in `plugins/`** (downloaded by setup).
2. Start the server once so TAB generates its default `plugins/TAB/config/`
   folder. Then stop the server.
3. Replace the auto-generated configs with the templates:

   ```
   copy setup\configs\tab\config.yml      plugins\TAB\config\config.yml
   copy setup\configs\tab\groups.yml      plugins\TAB\config\groups.yml
   copy setup\configs\tab\animations.yml  plugins\TAB\config\animations.yml
   ```

   Note the nested `config\` folder under `plugins\TAB\` (TAB 6.x change -
   in TAB 5.x and earlier these files were directly under `plugins/TAB/`).

4. Reload:

   ```
   /tab reload
   ```

## What you get

### Tab list

- **Header**:
  ```
  ----- LIFESTEAL SMP -----
  LIFESTEAL >> player <<
  Survive. Build. Kill. Repeat.
  Online: 12/100   Staff: 2
  ```
- **Footer**:
  ```
  Discord: discord.gg/example  (blinking)
  Hint: Vote with /vote        (rotating)
  Ping: 50ms  Memory: 1200/4096 MB
  -----------------------------
  ```
- **PvP world variant**: red theme, "Combat tag: 15s" warning header.
- **Player rows**: sorted by rank weight (owner top -> default bottom), then
  by balance descending. Each row shows: rank prefix + name + yellow
  ping number on the right (via the player-list-objective slot).

### Sidebar Scoreboard

Per-world boards toggle automatically when you change worlds:

| World | Title | Lines |
| --- | --- | --- |
| `world` (survival) | rainbow `>> LIFESTEAL <<` | name, rank, balance, level, kills/deaths/K-D, hearts, clan, rotating hint, online, Discord |
| `world_nether` | red `>> NETHER <<` | name, rank, balance, "watch out", online |
| `world_the_end` | purple `>> THE END <<` | name, balance, boss hint, online |
| `pvp_world` | red `>> PVP ARENA <<` | hearts, kill streak, kills, K/D, "No /spawn while tagged" |

Players toggle with `/sb` (their choice is remembered).

### Nametags above heads

Each player gets:
- A prefix tag (rank, e.g. `[VIP]`) - colored to match rank.
- A below-name line (e.g. `5 HP` red hearts via the belowname objective).
- An above-name line for staff (e.g. `[OWNER]`).

### Animations

- `%animation:brand%` - typewriter `LIFESTEAL` effect.
- `%animation:rainbow%` - cycles 7 colours.
- `%animation:pulse_red%` - blinking decorator.
- `%animation:blink_discord%` - blue discord blink.
- `%animation:ticker_hint%` - rotating hint ("Vote: /vote", "Quests: /quests gui", ...).

## Commands

| Command | Description | Perm |
| --- | --- | --- |
| `/tab reload` | Reload all TAB configs | `tab.admin` |
| `/tab cpu` | TAB CPU usage report | `tab.admin` |
| `/tab bossbar` | Manage bossbars | `tab.admin` |
| `/sb` | Toggle scoreboard | default |
| `/sb on` / `/sb off` | Force on/off | default |

## Permissions

TAB grants `tab.admin` to ops by default. For non-op admins:

```
/lp group admin permission set tab.admin true
/lp group default permission set tab.scoreboard.toggle true
```

## Placeholder syntax (TAB 6.x)

TAB 6 uses **dashes** for the LuckPerms placeholders, not underscores:

- `%luckperms-prefix%` (NOT `%luckperms_prefix%`)
- `%luckperms-suffix%`
- `%group%` - the player's primary group name
- `%ping%` - player ping (no need for `%player_ping%`)
- `%world%`, `%worldonline%`, `%staffonline%`, `%maxplayers%` - all built-in
- `%memory-used%`, `%memory-max%`

PlaceholderAPI placeholders work as normal: `%vault_eco_balance%`,
`%statistic_player_kills%`, `%auraskills_overall_level%`, etc.

## Customising

### Change a colour / message

Edit `plugins/TAB/config/config.yml`, then `/tab reload`. No restart needed.

### Add a personal scoreboard for a single player

In `config.yml -> scoreboard.scoreboards`:

```yaml
zaid_only:
  display-condition: '%player%=Itx_Zaid_3'
  title: '&4&l>> ZAID <<'
  lines:
    - '&7You are the owner.'
    - '&7Balance: &a$%vault_eco_balance%'
```

`display-condition` accepts placeholders, so you can gate on world, rank,
team, balance threshold, etc. Multiple conditions joined with `;` are AND'd.

### Per-rank tab name colour

Edit `groups.yml` -> `customtabname: '&5%player%'`. The colour applies just
to that rank's row in the tab list.

### Per-world prefix

Uncomment the `per-world:` block at the bottom of `groups.yml` and set
overrides per world (e.g. red prefix in PvP world).

### Custom kill-streak placeholder

The PvP board references `%tab_killstreak%`. Define it via a small
PlaceholderAPI custom-expansion or wire it via Quests events that store the
streak in player metadata.

## Troubleshooting

| Symptom | Fix |
| --- | --- |
| Tab is empty | TAB jar not loaded, or `/papi reload` not run. |
| Prefix wrong colour | Make sure groups in `groups.yml` are lowercase matching your LuckPerms group names. |
| Scoreboard shows raw `%placeholder%` | Install the PAPI expansion that owns it (`/papi ecloud download <name>`). |
| FPS drops on tab open | Lower polling rate in `config.yml -> placeholder-refresh-intervals`. |
| Nametag duplicated | Disable conflicting plugin's nametag (e.g. EssentialsX nametags). |
| Players see another player's scoreboard | `/sb off` once. Their preference now sticks. |
| Config changes don't apply | `/tab reload`. If still broken, restart the server (some sections require restart). |
| TAB v5 config no longer works | TAB 6 changed the folder layout - configs moved to `plugins/TAB/config/`. Migrate by hand or delete and let v6 regenerate, then copy our templates. |
