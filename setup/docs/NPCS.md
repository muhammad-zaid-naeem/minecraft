# NPCs

LifeSteal SMP uses **ZNPCsPlus 2.0.0** for all spawn NPCs. NPCs persist in
`plugins/ZNPCsPlus/storage/npcs.yml` and are re-spawned on every server boot.

## Roster (18 NPCs)

| ID | Coord | Display Name | Skin | Click action |
| --- | --- | --- | --- | --- |
| spawn_guide | (0, 101, 5) | Spawn Guide | Hypixel | `warp spawn` |
| shop_npc | (5, 101, 0) | Server Shop | MHF_Villager | `shop` |
| daily_npc | (7, 101, 2) | Daily Rewards | MHF_PigZombie | `crate preview daily` |
| vote_npc | (9, 101, 0) | Vote Rewards | MHF_Cactus | `vote` |
| quests_npc | (-5, 101, 0) | Quests | MHF_Librarian | `quests gui` |
| bp_npc | (-7, 101, 2) | Battle Pass | Notch | `battlepass` |
| crates_npc | (0, 101, -5) | Crates | MHF_Present1 | `crate menu` |
| rules_npc | (3, 101, -5) | Rules | MHF_Lawyer | `rules` |
| rtp_npc | (-3, 101, -5) | Random TP | MHF_Steve | `rtp` |
| clans_npc | (5, 101, -3) | Clans | MHF_Pirate | `clan` |
| pvp_npc | (10, 101, 0) | PvP Arena | MHF_Skeleton | `warp pvp` |
| bosses_npc | (-10, 101, 0) | Bosses | MHF_Wither | `warp bosses` |
| help_npc | (0, 101, 8) | Help | MHF_Question | `help` |
| discord_npc | (5, 101, 8) | Discord | MHF_Enderman | `discord` |
| info_npc | (-5, 101, 8) | Information | MHF_Alex | `warp info` |
| ranks_npc | (7, 101, -2) | Ranks | MHF_Chest | `warp store` |
| ah_npc | (8, 101, -8) | Auction House | MHF_CaveSpider | `ah` |
| pshop_npc | (-8, 101, -8) | Player Shops | MHF_Golem | `qs list` |

Each NPC has a 2-line hologram above its head (name + hint). Full text for
each is in `setup/npcs/spawn_npcs.txt`.

## Skins

ZNPCsPlus 2.0 fetches skins from Mojang by name. `MHF_*` are classic
mob-head skins. Replace any with another Minecraft account name to update.

```
npc skin set <id> <minecraft-name>
```

## Creating the roster

Paste the file `setup/npcs/spawn_npcs.txt` into the server console (skip
comment lines). It runs:

```
npc create <id> PLAYER world <x> <y> <z>
npc skin set <id> <name>
npc holo add <id> "<line 1>"
npc holo add <id> "<line 2>"
npc action add <id> RUN_COMMAND "<command>"
```

## Maintenance

### Move an existing NPC

Walk to the desired location (any Y), face the direction you want the NPC to
look, then:

```
npc move <id>
```

Or specify coords:

```
npc move <id> <world> <x> <y> <z>
```

### Delete an NPC

```
npc delete <id>
```

This both removes the entity and prunes its entry from `npcs.yml`.

### Rename / re-skin

```
npc holo set <id> <line-index> "<new text>"
npc skin set <id> <new-name>
```

### Add a new NPC

```
npc create <id> PLAYER world <x> <y> <z>
npc skin set <id> <name>
npc holo add <id> "&6&l<Display Name>"
npc holo add <id> "&fHint line"
npc action add <id> RUN_COMMAND "<command-without-slash>"
```

For NPCs that open a menu or run a chained command, repeat `npc action add`
with multiple RUN_COMMAND actions; they fire in order.

### Make an NPC look at the player

```
npc edit <id> look-close true
```

### Toggle hologram visibility

```
npc edit <id> show-name false
```

### Verify

```
npc list
npc near 50
npc info <id>
```

## Where the file lives

`plugins/ZNPCsPlus/storage/npcs.yml`. Format:

```yaml
spawn_guide:
  type: PLAYER
  location:
    world: world
    x: 0.0
    y: 101.0
    z: 5.0
    yaw: 0.0
    pitch: 0.0
  hologram:
    lines:
      - "&6&lSpawn Guide"
      - "&fRight-click for tour"
  actions:
    - type: RUN_COMMAND
      data: "warp spawn"
  skin:
    value: "<base64>"
    signature: "<signature>"
```

Manual editing requires a reload: `/npc reload`.

## Troubleshooting

| Symptom | Fix |
| --- | --- |
| NPC invisible to some players | They're too far - increase `default-look-range` in ZNPCsPlus config or run `/npc reload`. |
| Skin shows as Steve | Re-run `/npc skin set <id> <name>`; Mojang skin lookup can fail temporarily. |
| Click doesn't run command | Check the player has perms to run the action target command. RUN_COMMAND runs AS the clicking player by default. |
| Run as console instead | `npc action add <id> RUN_CONSOLE "<cmd>"` |
| Hologram doesn't update | DecentHolograms / ZNPCsPlus tracks the line text statically. Restart the holo task: `/npc reload`. |
