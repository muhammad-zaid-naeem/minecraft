# Wild World (RTP destination)

A dedicated `wild` world for random teleport / resource gathering.

## Why a separate world?

- **Spawn world stays pristine** — no big holes, no claims spammed around `(0,0)`.
- **PvP-friendly** — wild can be more dangerous than survival.
- **Resets safely** — you can wipe `wild/` every few months without losing player builds.
- **Faster generation** — pre-generate `wild` with Chunky once, then RTP is instant.

## Plugin stack

- **Multiverse-Core 5.7.0** (already installed) — creates and manages the wild
  world, plus per-world flags.
- **EssentialsX `/rtp`** — actually does the random teleport. Configured to
  always target the `wild` world.
- **`/wild` alias** in `commands.yml` — shortcut command.

## First-time setup (one-off)

After both plugins are installed and the server restarted:

```
mv create wild normal
mv modify set pvp true wild
mv modify set difficulty hard wild
mv modify set portalForm NONE wild
mv modify set respawnWorld world wild
mv modify set alias &6Wild wild
worldborder set 10000 wild
worldborder center 0 0 wild
```

Full script: `setup/wild/wild_world_setup.txt`.

Then move EssentialsX config:

```
copy setup\configs\essentials\rtp-override.yml  (merge into) plugins\Essentials\config.yml
```

The `rtp:` section there:
- Sets a 60-second cooldown.
- 500 to 5000 block range from `(0,0)`.
- Always targets the `wild` world regardless of which world the player runs
  `/rtp` from (except the End, which is disabled to keep dragon fights fair).
- Blacklists ocean / river biomes so players don't land in water.

Restart Essentials (or the server) to apply.

## Player commands

| Command | Effect |
| --- | --- |
| `/rtp` | Random teleport into the wild world |
| `/wild` | Alias of `/rtp` |
| `/mv tp wild` | Direct teleport to wild spawnpoint (no RTP) |
| `/spawn` | Return to main world spawn |
| `/menu wild` | Open the GUI selection menu (DeluxeMenus) |

## Admin / staff commands

| Command | Effect |
| --- | --- |
| `/mv list` | List all worlds |
| `/mv info wild` | World stats (size, players, gamerules) |
| `/mv modify set <prop> <val> wild` | Set a world property |
| `/mv reload` | Reload Multiverse configs |
| `/mv delete wild` | (Danger) delete the world |
| `/mv setspawn` | Set wild spawnpoint to your current position |
| `/worldborder set 10000 wild` | Resize world border (forces RTP within radius) |

## Pre-generating wild

For best player experience, pre-generate ~5000 blocks of chunks around
(0,0) so RTP is instant. Install **Chunky** plugin:

```
chunky world wild
chunky radius 5000
chunky start
```

Takes 30-90 minutes depending on disk + CPU. The server stays online.

## Resetting the wild world

Every 1-3 months you can wipe `wild` and re-generate so resources stay fresh.
Process (downtime ~5 min):

```
1. /mv tp @a world       # kick everyone back to spawn
2. say "Wild reset in 60 seconds - return to spawn now."
3. /mv unload wild
4. /mv delete wild
5. (manually delete the wild/ folder under D:\server\ if Multiverse leaves it)
6. /mv create wild normal -s NEW_SEED
7. chunky world wild ; chunky radius 5000 ; chunky start
```

Players will love the freshness.

## Spawn protection / claims in wild

Default: GriefPrevention claims allowed in wild. If you want it to be a pure
free-for-all zone (no claims, full PvP, no protection), edit
`plugins/GriefPrevention/config.yml`:

```yaml
ClaimsWorldModes:
  wild: Disabled
```

Then `/gpreload`.

## Common tweaks

| Want this? | Edit |
| --- | --- |
| Bigger range | `min-range` / `max-range` in `rtp-override.yml` |
| Different cooldown by rank | `cooldown-bypass: vip` perm in Essentials |
| Disable RTP from End | already set in `rtp-override.yml` |
| Disable RTP from PvP world | add `pvp_world: { enabled: false }` to world-options |
| Force lava/wall safety check | EssentialsX already checks; raise `max-tries` if too many "no safe location" warnings |
