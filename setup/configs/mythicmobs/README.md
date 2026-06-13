# MythicMobs Custom Content

YAML configs that ship LifeSteal SMP's custom mobs, bosses, items,
enchantments, loot tables, skills and seasonal events.

## Drop-in destination

Copy the directory tree directly into `plugins/MythicMobs/`:

```
plugins/MythicMobs/
+-- Mobs/
|   +-- CustomMobs.yml
|   +-- Bosses.yml
|   +-- LootTables.yml
+-- Items/
|   +-- CustomItems.yml
|   +-- CustomEnchants.yml
+-- Skills/
|   +-- BossSkills.yml
+-- SpawnRules/
|   +-- Spawners.yml
+-- Mobs/
    +-- SeasonalEvents.yml         (treat as "Mobs" - they ARE mobs)
```

After copying:

```
/mm reload
```

## Cheat-sheet

| Command | Description |
| --- | --- |
| `/mm m list` | List all mobs |
| `/mm m spawn <Mob> <amount>` | Spawn at your location |
| `/mm m spawn <Mob> 1 <x> <y> <z>` | Spawn at coords |
| `/mm i list` | List items |
| `/mm i give <Item> [amount]` | Give yourself an item |
| `/mm s list` | List skills |
| `/mm s cast <skill> [target]` | Manually cast a skill |
| `/mm reload` | Reload all configs |
| `/mm test` | Inline tester |
| `/mm m killall <Mob>` | Kill all of a mob |

## Files in this folder

| File | Purpose |
| --- | --- |
| `Mobs/CustomMobs.yml` | 6 regular custom mobs (ShadowZombie, ForestArcher, CaveWarden, IceGolem, InfernalCreeper, SwampWitch) |
| `Mobs/Bosses.yml` | 5 phased bosses (PyroLord, FrostMonarch, VoidEntity, EarthShaker, DragonOfAges) |
| `Mobs/LootTables.yml` | 8 named drop tables |
| `Items/CustomItems.yml` | 10 boss / cosmetic items |
| `Items/CustomEnchants.yml` | 10 custom enchant books (Lifesteal, Vampire, Berserk, Glacial, Phoenix, Thunderlord, WindSlash, Soulbound, Telepathy, VeinMine) |
| `Skills/BossSkills.yml` | Boss skill mechanics (PyroNova, IceShards, VoidStep, EarthQuake, DragonBreath, MinionSummon) |
| `SpawnRules/Spawners.yml` | Random natural spawn rules |
| `Events/SeasonalEvents.yml` | Holiday bosses (PetalGuardian, BeachKing, PumpkinKing, KrampusKing) |

## Testing tips

- Always run `/mm reload` after editing a yml. Errors print to console.
- Spawn a boss safely in creative first: `/gamemode 1` then `/mm m spawn PyroLord 1`.
- Use `/mm i give <id>` to inspect item NBT.
- The boss BossBar appears server-wide automatically; use `/mm m killall <id>`
  to clean up a failed test.
