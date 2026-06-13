# Spawn Layout

Spawn center: `(0, 101, 0)` in world `world`. Spawn protection radius: 30 blocks
(`server.properties`).

A FAWE schematic `red_spawn.schem` lives at `D:\server\`. Paste at spawn with
`/fawe paste red_spawn.schem` (or `build_spawn.ps1`).

## Top-down map (Z increases north on map, X east)

```
                           +Z (NORTH)
                              |
                              |
        west  -8                     +8  east
              .                       .
              .                       .
              .  -5 info_npc 0     5  .
              .       help_npc        .
              .   discord_npc         .
              .      |                .
              .      |                .
   bosses_npc - quests bp -- SPAWN -- shop daily vote pvp - X+
   (-10,0)        (-5..-7,0..2)  (0,0)  (5..9,0..2) (10,0)
              .      |                .
              .      |                .
              .   quests_board        .
              .      |                .
              .   rtp_npc  rules_npc  .
              .  (-3,-5)   (3,-5)     .
              .       crates_npc      .
              .       (0,-5)          .
              .                       .
              .  pshop_npc    ah_npc  .
              .  (-8,-8)      (8,-8)  .
                              |
                          -Z (SOUTH)
```

Y level for everything visible: 101 (NPC feet), 102 (NPC heads / labels), 103
(leaderboards), 105 (welcome hologram).

## Zones

### Center hub (0, 101, 0)

- **Spawn point** (`/setworldspawn 0 101 0`).
- **Spawn Guide NPC** at (0, 101, 5) - greets new players.
- **Welcome hologram** at (0, 105, 0) - 4 lines (name, tagline, IP, Discord).

### Information Area (north -5..5 X, 8 Z)

- **Help NPC** (0, 101, 8) - opens `/help`.
- **Discord NPC** (5, 101, 8) - opens Discord invite link.
- **Information NPC** (-5, 101, 8) - server info & MOTD.
- **Discord info hologram** at (5, 102, 8).
- Decorative blocks: bookshelf walls, lecterns, item-frame screenshots.

### Rules Area (south, 3, -5)

- **Rules NPC** (3, 101, -5).
- **Rules hologram** at (3, 102, -5) - clickable lead to `/rules`.
- Decorative: signs with each rule on a wall.

### Crates Area (south, x=-4..4, z=-7)

- **Crates NPC** (0, 101, -5).
- **5 physical crate chests** at:
  - vote      (-4, 101, -7)
  - daily     (-2, 101, -7)
  - rare      ( 0, 101, -7)
  - epic      ( 2, 101, -7)
  - legendary ( 4, 101, -7)
- **Crates label hologram** above at (0, 103, -7).
- Decorative: red/gold particle accents (Beacon ground), trapdoor fence.

### Shop Area (east, 5..9, 0..2)

- **Server Shop NPC** (5, 101, 0).
- **Daily Rewards NPC** (7, 101, 2).
- **Vote Rewards NPC** (9, 101, 0).
- **Shop label hologram** (5, 102, 0).
- Decorative: villager stalls with item-frame previews.

### Quests Area (west, -5..-7, 0..2)

- **Quests NPC** (-5, 101, 0).
- **Battle Pass NPC** (-7, 101, 2).
- **Quests board** (wall of item frames) behind NPCs at z=-1.

### PvP Portal (east edge, 10, 0)

- **PvP Arena NPC** (10, 101, 0) - teleports to `/warp pvp`.
- **PvP entry hologram** (10, 102, 3).
- Decorative: nether portal block, blackstone arch, particle flame.

### Bosses Portal (west edge, -10, 0)

- **Bosses NPC** (-10, 101, 0) - teleports to `/warp bosses`.
- Decorative: end portal frame ring, soul fire torches, obsidian arch.

### RTP Portal (south, -3, -5)

- **RTP NPC** (-3, 101, -5).
- **RTP entry hologram** (-3, 102, -5).
- Decorative: jungle leaves arch, particle ground effect.

### Discord Area (north-east, 5, 8)

- **Discord NPC** above.
- **Discord hologram** (5, 102, 8) - shows server invite + live status.

### Leaderboards Area (x=15 & x=-15)

- East side at (15, 103, 0..10):
  - **Top Money** hologram (15, 103, 0)
  - **Top Kills** hologram (15, 103, 5)
  - **Top Level** hologram (15, 103, 10)
- West side at (-15, 103, 0):
  - **Top Voters** hologram (-15, 103, 0)
- Decorative: stone podiums underneath, gold-block-and-armor-stand "trophy".

### NPC Hub Area (full radius 0..10)

All 18 spawn NPCs are within a 10-block radius of (0, 101, 0). Layout:

| NPC | Coord |
| --- | --- |
| Spawn Guide | (0, 101, 5) |
| Help | (0, 101, 8) |
| Info | (-5, 101, 8) |
| Discord | (5, 101, 8) |
| Quests | (-5, 101, 0) |
| Battle Pass | (-7, 101, 2) |
| Server Shop | (5, 101, 0) |
| Daily Rewards | (7, 101, 2) |
| Vote Rewards | (9, 101, 0) |
| Ranks | (7, 101, -2) |
| Crates | (0, 101, -5) |
| Rules | (3, 101, -5) |
| RTP | (-3, 101, -5) |
| Clans | (5, 101, -3) |
| PvP Arena | (10, 101, 0) |
| Bosses | (-10, 101, 0) |
| Auction House | (8, 101, -8) |
| Player Shops | (-8, 101, -8) |

### Auction House platform (south-east, 8, -8)

- **Auction House NPC** (8, 101, -8) - `/ah`.
- **AH hologram** (8, 102, -8).
- Decorative: 4x4 podium, item frames showcasing hot listings.

### Player Shops platform (south-west, -8, -8)

- **Player Shops NPC** (-8, 101, -8) - `/qs list`.
- **Player Shops hologram** (-8, 102, -8).
- Decorative: small market stalls; suggest building a community "market"
  district at `/warp market` (100, 70, 100) where players can rent plots and
  open QuickShops.

## Spawn protection

- Server `spawn-protection: 30` blocks (`server.properties`).
- GriefPrevention claim around spawn auto-created on first build.
- Suggest manually creating a 60x60 admin claim:
  - Stand at (-30, 100, -30).
  - `/adminclaims` then place a golden shovel at corner.
  - Drag to (30, 200, 30) to lock the air column.
  - Run `/restrictsubclaim` and set permissions to none for default.

## Build / paste workflow

```
/wand                                       # WE wand
//pos1 -30 99 -30
//pos2 30 130 30
/fawe paste red_spawn.schem -p              # paste at current pos
/setworldspawn 0 101 0
/spawn                                      # test
```

Then run:

```
... paste setup\warps\warps_setup.txt
... paste setup\npcs\spawn_npcs.txt
... paste setup\holograms\holograms_setup.txt
```

Verify the visible layout above is intact.
