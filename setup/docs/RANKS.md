# Ranks

LifeSteal SMP uses a 7-tier rank ladder, managed via **LuckPerms**. Prefixes
display in chat and tab.

## Ladder

| Rank    | Prefix              | Weight | Parent   | Price    | Audience             |
| ------- | ------------------- | ------ | -------- | -------- | -------------------- |
| default | `&7[Player]`        | 10     | -        | free     | every new player     |
| vip     | `&a[VIP]`           | 20     | default  | $5 USD   | first donor tier     |
| mvp     | `&b[MVP]`           | 30     | vip      | $15 USD  | mid donor tier       |
| elite   | `&5[ELITE]`         | 40     | mvp      | $30 USD  | top donor tier       |
| mod     | `&2[MOD]`           | 80     | elite    | staff    | trial / full mods    |
| admin   | `&c[ADMIN]`         | 90     | mod      | staff    | senior staff         |
| owner   | `&4&l[OWNER]`       | 100    | admin    | staff    | server owner only    |

Donor ranks are pay-once and persist forever. Staff ranks are revoked when the
person leaves the team.

## Earning a paid rank (alternative to purchasing)

| Rank | Playtime requirement | Confirm via |
| --- | --- | --- |
| vip | 30 hours played AND $5000 in balance | manual staff promotion |
| mvp | 100 hours played AND beat 1 boss | manual |
| elite | 250 hours played AND own a clan | manual |

Staff give the rank with `/lp user <name> parent set <rank>`.

## Perks summary

### default (every player)

- `/spawn`, `/sethome` (1 home), `/home`, `/tpa`, `/back`, `/rtp`, `/msg`,
  `/mail`, `/balance`, `/pay`, `/baltop`, `/afk`.
- `/warp spawn|pvp|bosses|info|store|tour|market|events`.
- GriefPrevention: claim, trust, untrust (own claims).
- AuraSkills: `/skills`, `/stats`, `/skilltop`.
- Quests: `/quests gui`, view & accept quests, claim rewards.
- SimpleClans: full member commands (no admin).
- QuickShop: create up to 3 shops, browse all shops.
- ExcellentCrates: open / preview / view keys.
- PlayerParticles: `/pp gui` with the basic style set.

### vip ($5)

- 3 homes (was 1).
- `/fly` in claims and survival (no fly in PvP).
- `/kit vip` weekly.
- `/nick` to set a coloured nickname.
- `/feed` daily.
- Chat colours `&` codes allowed in messages.
- 13 unlocked particle styles.

### mvp ($15)

- 5 homes.
- `/kit mvp` weekly (better loot).
- `/heal` (3-minute cooldown).
- `/repair` (chest or held item, 10-min CD).
- Chat format colours (custom prefix flair).
- 25 unlocked particle styles.

### elite ($30)

- 10 homes.
- `/god` for short bursts (1 minute, 15-min CD).
- `/kit elite` weekly (top-tier loot).
- `/invsee` for friends-only.
- All 50+ particle styles.
- Custom hat slot (head + special-item slot).

### mod (staff)

- Mute / kick / tempmute / warn.
- StaffPlus full toolkit (`/sm`, vanish, freeze, examine).
- CoreProtect lookup + inspect.
- GriefPrevention staff (override claims when investigating).
- AdvancedBan full ban-stack.

### admin (staff)

- All Essentials commands.
- WorldEdit + FastAsyncWorldEdit.
- LuckPerms editor + user management.
- DiscordSRV admin (config reload).
- ZNPCsPlus + DecentHolograms full control.
- CoreProtect rollback / purge.

### owner

- Wildcard `*`. Avoid using day-to-day - log in as `admin` for routine work.

## Reference

- Apply script: `setup/luckperms/ranks_setup.txt`.
- Permission catalog per rank: `setup/docs/PERMISSIONS.md`.
- LuckPerms web editor: run `/lp editor` in-game for a URL.
