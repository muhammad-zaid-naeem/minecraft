# Crates

5-tier crate system, powered by **ExcellentCrates 6.6.1**. Each tier is
balanced for a specific economy moment.

| Tier | Colour | Key source | Crate location |
| --- | --- | --- | --- |
| Vote | green | 1 per vote | (-4, 101, -7) |
| Daily | yellow | 1 per 24h login | (-2, 101, -7) |
| Rare | aqua | shop / boss / event | (0, 101, -7) |
| Epic | gold | shop / boss / event | (2, 101, -7) |
| Legendary | red | boss / events only | (4, 101, -7) |

Open at the physical crate block by right-clicking with the key. Or use
`/crate menu`.

## Vote Crate (vote)

| Reward | Chance |
| --- | --- |
| $500 | 60% |
| 16 diamonds | 20% |
| 30 XP levels | 15% |
| 1 Legendary Key | 5% |

Players get **1 Vote Key** per vote on each of the 4 partner sites = up to
4 keys per day.

## Daily Crate (daily)

| Reward | Chance |
| --- | --- |
| $200-500 | 30% |
| Food bundle (golden carrots, bread, cooked beef) | 20% |
| Basic gear (iron set, sword) | 15% |
| 1 Vote Key | 25% |
| 1 Rare Key | 10% |

Key delivered automatically every 24h via the scheduler in
`setup/configs/excellentcrates/crates/daily.yml`.

## Rare Crate (rare)

| Reward | Chance |
| --- | --- |
| $1000-5000 | 40% |
| Enchanted diamond gear (sharp 4, prot 4) | 30% |
| 1 Epic Key | 20% |
| 1 Legendary Key | 7% |
| Rare boss spawn egg (random mid-tier mob) | 3% |

Shop price for a Rare Key: $5000.

## Epic Crate (epic)

| Reward | Chance |
| --- | --- |
| $10000 | 35% |
| Netherite piece (random armor or sword) | 25% |
| Custom enchant book (Lifesteal, Berserk, Glacial) | 20% |
| 1 Legendary Key | 15% |
| Rare boss spawn egg (PyroLord / FrostMonarch) | 5% |

Shop price for an Epic Key: $15000.

## Legendary Crate (legendary)

| Reward | Chance |
| --- | --- |
| $50000 | 25% |
| Boss item drop (Pyrosword / FrostBow / VoidBlade / EarthHammer) | 30% |
| DragonScale piece (random) | 15% |
| Rare boss spawn egg (VoidEntity / EarthShaker) | 15% |
| Pet egg (Phoenix / Krampus / Dragon) | 10% |
| Exclusive cosmetic (trail + tag combo) | 5% |

Shop price for a Legendary Key: $50000 (intentionally steep - drives players
to bosses + events).

## Key sources summary

| Key | Sources |
| --- | --- |
| Vote | voting (1 per site) |
| Daily | login (24h) |
| Rare | shop ($5000), Daily Crate roll, Quest weekly reward |
| Epic | shop ($15000), Rare Crate roll, Boss drop (PyroLord/FrostMonarch) |
| Legendary | shop ($50000), Boss drop (VoidEntity/EarthShaker/DragonOfAges), Vote Crate 5% roll, Battle Pass tier 100 |

## Test the crates

```
crate key give <yourname> vote 5
crate key give <yourname> daily 1
crate key give <yourname> rare 3
crate key give <yourname> epic 2
crate key give <yourname> legendary 1
crate preview legendary    # see rewards without opening
```

Open by walking up to the corresponding crate block and right-clicking.

## Animations

ExcellentCrates 6.6.1 supports 8 animation types. Recommended setting per
crate:

| Crate | Animation |
| --- | --- |
| Vote | SPIN (fast, snappy) |
| Daily | ROULETTE |
| Rare | CASINO |
| Epic | WHEEL |
| Legendary | GACHA (cinematic) |

Set in the yml per crate, key `opening.type`.

## Admin actions

```
crate reload                            # reload yml definitions
crate key give <player> <id> <amount>
crate key giveall <id> <amount>
crate giveall <id> <amount>             # gives the crate item itself
crate menu set                          # bind a physical chest
crate purge <id>                        # purges drops history
```

## Source files

- Crate definitions: `setup/configs/excellentcrates/crates/<tier>.yml`.
- Setup script: `setup/crates/crates_setup.txt`.
- Holograms above each crate: in `setup/holograms/holograms_setup.txt`.
- Permissions: `excellentcrates.player` (default), `excellentcrates.admin`
  (admin).
