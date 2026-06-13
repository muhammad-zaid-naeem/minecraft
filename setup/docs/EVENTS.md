# Seasonal Events

A rolling calendar of seasonal events. Most use **MythicMobs** custom bosses
and **ExcellentCrates** event-only crates. Configurations live under
`setup/configs/mythicmobs/Events/SeasonalEvents.yml`.

## Calendar

| Season | Months | Events |
| --- | --- | --- |
| Spring | Mar-May | Easter Egg Hunt, PetalGuardian boss |
| Summer | Jun-Aug | BeachKing boss, Tropical PvP |
| Autumn | Sep-Nov | Halloween / PumpkinKing, Harvest Festival |
| Winter | Dec-Feb | Christmas / KrampusKing, Snowball Tournament |

## Spring

### Easter Egg Hunt

- Schedule: April 1 - April 30.
- Hidden eggs spawn at random world coords (50-300 block radius from spawn).
- Players find and break = 1 candy + chance of pet egg.
- Plugin: custom Quests entry `egg_hunt_2026` (see `quests.yml`).
- Total eggs: 100; first to find 50 = exclusive title "Egg Master".

### PetalGuardian Boss

- HP: 2000. Spawns flower minions. Drops Bunny pet egg + Spring Trail + $5000.
- Manual start: `/mm m spawn PetalGuardian 1 ~ ~ ~`.
- Schedule: 4 spawns per week at random forest coords during Spring.

## Summer

### BeachKing Boss

- HP: 2200. Drops Trident (Channeling 1) + Sun cosmetic + $6000.
- Spawns at beaches (custom SpawnRule).
- Manual: `/mm m spawn BeachKing 1 ~ ~ ~`.

### Tropical PvP

- PvP arena reskinned with sand/palm decorations.
- Bonus +10% drops in PvP arena during Summer.
- Daily kit `summer_kit` includes melon + golden apple + cocktail item.

## Autumn

### Halloween / PumpkinKing

- Duration: October 1 - November 1.
- All zombies have a 20% chance to be replaced by SkellyHalloween (custom
  cosmetic skeleton).
- World cosmetic: pumpkin and cobweb particles around spawn.
- **PumpkinKing** boss spawns daily at 20:00 UTC.
  - HP: 4000.
  - Drops: Pumpkin Head (custom helmet, prot 4 + night vision), Krampus pet
    egg (rare, 5%), Halloween Trail, $15000, 2 Legendary Keys.
- Halloween Crate (limited-time event crate):
  - Key obtained via `event_halloween` quests.
  - Rewards: SkeletonHat, GhastPet, scary chat suffix tags.

### Harvest Festival

- Bonus +50% Farming XP for entire season.
- Special quest `harvest_50_pumpkins` rewards $1000.
- Decoration: pumpkin pies + scarecrow armorstands at spawn.

## Winter

### Christmas / KrampusKing

- Duration: December 1 - January 7.
- Snow texture overlay (resource pack only).
- **KrampusKing** boss spawns daily at 21:00 UTC.
  - HP: 4500.
  - Drops: Snowflake item (cosmetic), Winter Trail, Snowglobe block, Polar Pet
    egg (rare), $18000, 2 Legendary Keys.
- Christmas Crate:
  - Key from "Light an Advent Candle" daily quest (24 candles, Dec 1-24).
  - Rewards: SantaHat, ReindeerPet, white prefix tags.

### Snowball Tournament

- Saturday nights in December at 20:00 UTC.
- Players join `/event start snowball` (admin-triggered).
- 1v1 snowball-only PvP at `/warp events`.
- Top 3: Legendary Key + $25000 (split).

## Year-round special

### Anniversary

- Date: server's anniversary (set in `setup/configs/mythicmobs/Events/SeasonalEvents.yml`).
- Auto-broadcast 1 hour before.
- Everyone online gets +1 Legendary Key + $5000.

### Double XP weekends

- Schedule: first weekend of every month.
- Auto-toggle via console: `/skillsadmin multiplier set 2.0`.
- Banner hologram added at spawn for the weekend.

## Manual triggers

| Command | Effect |
| --- | --- |
| `/mm m spawn PumpkinKing 1 ~ ~ ~` | Spawn the boss on top of you |
| `/event start <eventid>` | Trigger an event by ID (custom wrapper) |
| `/skillsadmin multiplier set 2.0` | 2x XP weekend |
| `/eco giveall 5000` | One-off cash gift (e.g. anniversary) |
| `/crate key giveall halloween 1` | Hand out limited-time keys |

## Scheduling

Use a host-level cron + RCON for production. Example Linux cron (run via
`mcrcon`):

```
# Daily PumpkinKing during October
0 20 * 10 * mcrcon -H 127.0.0.1 -P 25575 -p $RCON_PASS "mm m spawn PumpkinKing 1 50 100 50"

# Anniversary
0 0 15 7 * mcrcon -H 127.0.0.1 -P 25575 -p $RCON_PASS "broadcast Happy Anniversary! 1 Legendary Key for everyone." && \
  mcrcon -H 127.0.0.1 -P 25575 -p $RCON_PASS "crate key giveall legendary 1"
```

On Windows, use Task Scheduler with `mcrcon.exe` or DriveBackupV2's cron
hooks.

## /calendar (planned)

Suggested custom command `/calendar` (build via a small plugin or hook into
EssentialsX MOTD) that prints the current month's events + next boss spawn
time. Pseudo:

```
/calendar
  &6&l-- This Month --
  &fOct 1-31  - Halloween Event active
  &fOct 31   - PumpkinKing 20:00 UTC
  &fEvery Sat - Snowball Tournament 20:00 UTC
  &fNext boss in 4h 23m
```

## Event success metrics

Track engagement to know whether an event lands:

- Crate keys distributed (event-only).
- Quest completion rate.
- New accounts created during the event window.
- Player retention 1 week after event end.

Use Discord status channel ("online-N-of-100") + spark reports to measure.
