# Cosmetics

LifeSteal SMP's cosmetics layer is built on **PlayerParticles**, **LuckPerms
prefixes/suffixes** and (optionally) a pet plugin like MyPet.

## Pets

Two options - pick one based on your style:

### Option A: MyPet (recommended)

Install MyPet (see PLUGIN_LIST.md). Players capture vanilla mobs to use as
pets:

| Command | Description |
| --- | --- |
| `/pet <type>` | Spawn a pet (if you own a leash to it) |
| `/pet info` | View your active pet |
| `/pet release` | Release |
| `/petstore` | GUI for storing pets |

Pets level up by being near combat. Up to 5 pets stored, 1 active.

### Option B: MythicMobs friendlies

Drop the file `setup/configs/mythicmobs/Mobs/Pets.yml` (custom; not in this
package - see EVENTS.md for boss-pet rewards). A MythicMobs friendly mob with
`Faction: pets` becomes a follower. Cosmetic-only, no AI fighting.

Sample pet rewards:

- Bunny pet (Spring event drop)
- Krampus pet (Christmas event)
- Phoenix pet (Battle Pass tier 30 premium reward)
- Dragon pet (Legendary Crate 1% drop)

## Trails (particles)

PlayerParticles GUI: `/pp gui`.

| Rank | Unlocked styles count |
| --- | --- |
| default | basic styles (orbit, follow, point) |
| vip | 13 unlocked |
| mvp | 25 unlocked |
| elite | all 50+ unlocked |

Players set:

```
/pp gui                            (GUI)
/pp particles                      (list)
/pp add <effect> <style>           (add a layer)
/pp toggle                         (on / off)
```

Recommended VIP styles to unlock first: `flame`, `heart`, `note`, `cloud`,
`crit`, `enchant`, `villager_happy`, `wax_on`, `composter`, `sneeze`.

## Particle Effects (one-shot)

For boss kills, level-ups and event wins, MythicMobs Skills can fire single
particle bursts. Examples:

- Level-up burst: `effect:particles{p=totem_of_undying;a=200;hs=1.0}`
- Boss death: `effect:particles{p=soul_fire_flame;a=500;hs=3.0}`
- Win event: `effect:particles{p=firework;a=300;hs=2.0}`

## Name Tags (prefixes)

Managed via LuckPerms prefix metadata. Each rank gets a default prefix:

| Rank | Prefix |
| --- | --- |
| default | `&7[Player]` |
| vip | `&a[VIP]` |
| mvp | `&b[MVP]` |
| elite | `&5[ELITE]` |
| mod | `&2[MOD]` |
| admin | `&c[ADMIN]` |
| owner | `&4&l[OWNER]` |

Override a single user (e.g. Discord booster):

```
/lp user <name> meta setprefix 1 "&d[BOOSTER]"
```

Or stack a second prefix (weight 2):

```
/lp user <name> meta setprefix 2 "&6[VOTER]"
```

## Chat Tags (suffixes)

Suffixes appear after the player's name. Used for one-time achievements,
seasonal flair or premium tags purchased from the shop.

```
/lp user <name> meta setsuffix 1 " &7| &eDragonslayer"
/lp user <name> meta setsuffix 1 " &7| &cSeason 1 Champion"
/lp user <name> meta setsuffix 1 " &7| &5MVP Voter"
```

Recommended in-store "tag" purchases (one-time, lifetime):

| Tag | Cost | Display |
| --- | --- | --- |
| Cool | $5000 | ` &7| &bCool` |
| Pro | $10000 | ` &7| &6Pro` |
| God | $25000 | ` &7| &c&lGod` |
| Legend | $50000 | ` &7| &5&lLegend` |
| YouTuber | request only | ` &7| &c&lYT` |
| Streamer | request only | ` &7| &5&lTwitch` |

Wrap them in a `/tag set <id>` GUI command (custom plugin or LuckPerms macro).

## Hats / cosmetic slots

For an extra cosmetic slot, install **HatsLite** or use vanilla armorstand
trick:

- elite+ can wear any block as a hat: `/hat`.
- `/hat list` shows all wearable items.
- Hats are visual-only; do not give armor stats.

## Visual rank pages

Build a "Ranks" platform near (7, 101, -2) with item-frame previews of each
rank's perks. The Ranks NPC sends players to `/warp store` where signs (with
EssentialsX `[Buy]` signs or webstore links) sell each rank.

## Sounds / titles

Per-event sounds (configure in EssentialsX `kits.yml` or as a Quests action):

```
- 'sound %player% UI_TOAST_CHALLENGE_COMPLETE 1 1'
- 'title %player% subtitle "&aQuest complete!"'
- 'title %player% title "&6Rewards delivered"'
```

## Cosmetics shop suggestion

Open the EconomyShop GUI category **Cosmetics** later:

```
eshop create Cosmetics
eshop additem Cosmetics PAPER 100 5      # naming token
eshop additem Cosmetics FEATHER 250 25   # particle unlock token
eshop additem Cosmetics RABBIT_FOOT 5000 0   # rabbit pet token
```

Hook the tokens into commands (use a console action wrapper) so spending the
item triggers the cosmetic.
