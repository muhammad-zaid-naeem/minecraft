# Progression

Player progression comes from four systems running in parallel: **AuraSkills**
(player levels), **Quests** (dailies & weekly challenges), **Statistics**
(achievements), and a **Battle Pass** (seasonal track).

## Player Levels (AuraSkills)

12 skills, each leveling 1-100 independently. Overall level = sum / 12.

| Skill | Trained by |
| --- | --- |
| Farming | breaking crops |
| Mining | breaking ores / stone |
| Foraging | chopping wood |
| Fishing | fishing |
| Excavation | digging dirt/sand/gravel |
| Archery | bow hits |
| Defense | taking damage |
| Fighting | melee hits |
| Endurance | sprinting / swimming |
| Agility | running on slabs / jumping |
| Alchemy | brewing |
| Enchanting | enchanting / using XP |

Per-level reward: $10 + minor permanent stat. XP curve: base 100, multiplier
1.1 per level.

Commands:

- `/skills` - skill GUI
- `/stats` - current stats
- `/skilltop [skill]` - leaderboard

Leaderboard hologram: `(15, 103, 10)` - shows top 10 overall.

Placeholders:

- `%auraskills_overall_level%`
- `%auraskills_<skill>_level%`
- `%auraskills_top_overall_name_<n>%`
- `%auraskills_top_overall_value_<n>%`

## Daily Quests

Plugin: **Quests** (Pikamug). Reset: every day at 00:00 UTC. Category: `daily`.

| ID | Quest | Reward |
| --- | --- | --- |
| daily_kill_zombies | Kill 10 zombies | $150 |
| daily_mine_stone | Mine 50 stone | $100 |
| daily_harvest_wheat | Harvest 20 wheat | $100 |
| daily_fish | Catch 5 fish | $150 |
| daily_walk | Walk 1000 blocks | $200 |

Players accept up to 5 concurrent. Completion grants the cash reward plus +1
Battle Pass XP. See `setup/configs/quests/quests.yml` for definitions.

## Weekly Challenges

Reset: every Monday 00:00 UTC. Category: `weekly`.

| ID | Challenge | Reward |
| --- | --- | --- |
| weekly_dragon | Kill the Ender Dragon | $5000 + Legendary Key |
| weekly_diamonds | Mine 50 diamonds | $3000 + Epic Key |
| weekly_dailies | Complete 20 daily quests | $2500 + Rare Key |

## Achievements

Statistics tracked via vanilla `statistic` placeholders. Sample 20 (issue via
console with `/lp user <p> permission set achievement.<id> true` on grant):

| ID | Achievement | Trigger |
| --- | --- | --- |
| first_kill | First Blood | first PvP kill |
| ten_kills | Bloody | 10 PvP kills |
| hundred_kills | Bloodbath | 100 PvP kills |
| reach_l50 | Halfway There | overall level 50 |
| reach_l100 | Capped | overall level 100 |
| mine_10k_stone | Stonecutter | 10000 stone mined |
| mine_diamond | Shiny | first diamond mined |
| kill_dragon | Dragonslayer | kill Ender Dragon |
| kill_wither | Witherbane | kill Wither |
| boss_pyrolord | Pyromancer | kill PyroLord |
| boss_frost | Coldhearted | kill FrostMonarch |
| boss_void | Void Walker | kill VoidEntity |
| boss_earth | Tremor | kill EarthShaker |
| boss_dragon_ages | Eternal | kill DragonOfAges |
| craft_elytra | Skyborn | craft elytra |
| craft_beacon | Lighthouse | craft beacon |
| build_house | Architect | place 1000 blocks |
| reach_endcity | Explorer | enter end city |
| clan_create | Brotherhood | create a clan |
| vote_100 | Devoted | vote 100 times |

Grant via console or by hooking into Quests "complete" actions.

## Battle Pass

Implementation: **Quests** plugin with a "battlepass" branch category. 100
tiers; 3-month seasons.

Track types:

- **Free track** - cosmetic-light rewards, every 5 tiers.
- **Premium track** - bigger rewards every tier; unlocked with $20 in-game
  ($1500 or 1500 BP points) once per season.

Sample rewards by tier (free / premium):

| Tier | Free reward | Premium reward |
| --- | --- | --- |
| 1 | $200 | $500 + Vote Key |
| 5 | 5 vote keys | Daily Key + $1000 |
| 10 | $1000 | Rare Key + 1 cosmetic trail |
| 20 | Daily Key | Rare Key + $5000 |
| 30 | $2500 | Epic Key + custom pet |
| 50 | $5000 + Rare Key | Epic Key + exclusive cape |
| 75 | $7500 + Epic Key | Legendary Key + exclusive prefix |
| 100 | Legendary Key + $10000 | 5x Legendary Keys + DragonScale Boots + season title |

Gain BP XP from:

- Completing daily quests (1 BP XP each)
- Completing weekly challenges (10 BP XP each)
- Killing a custom boss (5-25 BP XP based on tier)
- Voting (1 BP XP per vote)
- Achievements (10 BP XP each)

Open BP GUI: `/battlepass` (NPC click maps to this).

## Stats placeholders (for chat / scoreboards)

```
%player_health%
%vault_eco_balance%
%auraskills_overall_level%
%auraskills_fighting_level%
%auraskills_mining_level%
%statistic_player_kills%
%statistic_mob_kills%
%statistic_deaths%
%statistic_play_one_minute%   (ticks since first join)
%votingplugin_total_votes_currentmonth%
%simpleclans_clan_tag%
%simpleclans_clan_kdr%
```

## Tab + chat format

Defaults via EssentialsX Chat. Edit `plugins/Essentials/config.yml`:

```yaml
chat:
  format: '{PREFIX} &f{DISPLAYNAME}&7: &f{MESSAGE}'
```

Tab list configurable via TAB plugin (optional install).
