# PvP

## Arenas + zones

- **Survival world**: PvP **on** outside protected claims. Inside a
  GriefPrevention claim, PvP is **off** by default (`PvP.NoCombatInPlayerLandClaims=true`).
- **Spawn**: 30-block protection radius; no PvP, no block break.
- **PvP arena**: `/warp pvp` at (50, 80, 50). Custom-built arena where PvP is
  forced **on** regardless of claims (configure via WorldGuard region or
  GriefPrevention subclaim).

## Combat tag (CombatLog+)

- Entering combat tags you for **15 seconds**.
- While tagged: `/spawn`, `/home`, `/tpa`, `/warp` and `/back` are blocked.
- If you log out while tagged, you die and drop your inventory.
- New players (< 24h playtime or unmoved from spawn) get a one-time
  protection until they leave spawn protection.

## LifeStealZ rules

| Event | Effect |
| --- | --- |
| Kill a player | +1 max heart (cap configurable; default 20) |
| Die in PvP | -1 max heart |
| Die at 1 heart | Eliminated - banned 24h or sent to lobby |
| Revive | Craft Revive Heart (8 hearts -> 1 revive item) |

Heart cap, revive cost and elimination behaviour are in
`plugins/LifeStealZ/config.yml`. Defaults are tuned for a "hard" LifeSteal SMP.

## Kill streaks

- Implemented via a simple Quests-or-script hook (or a dedicated KillStreak
  plugin). Per kill while alive: `$5 x current_streak`.
- Broadcast every 5 streak.
- Special broadcasts at 10 / 25 / 50 / 100 (custom title + sound).
- Streak resets on death.

Pseudo-config (drop into Quests `actions.yml` or a dedicated plugin):

```yaml
on_kill:
  - increment_streak
  - give_money '5 * streak'
  - if 'streak % 5 == 0': broadcast '&c{killer} is on a {streak} kill streak!'
  - if 'streak == 10': title {killer} '&6&lRAMPAGE!'
  - if 'streak == 25': title {killer} '&5&lUNSTOPPABLE!'
  - if 'streak == 50': title {killer} '&4&lGODLIKE!'
  - if 'streak == 100': title {killer} '&4&l!!! LEGEND !!!'
on_death:
  - reset_streak
```

## PvP events (scheduled)

| Event | Format | When | Reward |
| --- | --- | --- | --- |
| **1v1 Friday** | bracket of 16 | Friday 20:00 UTC | $10000 + Epic Key |
| **FFA Saturday** | 30-player free-for-all | Saturday 21:00 UTC | $25000 + Legendary Key |
| **Last Stand** | shrinking arena | Sunday 19:00 UTC | $15000 + Legendary Key |
| **Clan War** | 5v5 clan event | bi-weekly | Custom Boss Egg + $50000 (split among clan) |

Run from console: `/event start 1v1`, `/event start ffa`, `/event start laststand`.
The `event` command is a wrapper script; suggest a small custom plugin or a
DiscordSRV bot to schedule + announce these.

## Leaderboards

Holograms at `(15, 103, 5)` track top kills via
`%statistic_player_kills:<n>%`.

Suggested additional placeholders to add to TAB / chat:

- Top KDR: `%simpleclans_player_kdr%`
- Top kill streak: requires custom stat tracking (see Kill streaks pseudo-config).

## Recommended PvP loadout balance

The shop is priced so that a full Diamond loadout costs ~$5000 (gear + pots +
food). A full Netherite loadout costs ~$35000. This forces decisions on early
PvP gear tier.

| Tier | Approx total | Sweet spot |
| --- | --- | --- |
| Iron | $1500 | early game |
| Diamond | $5000 | mid game |
| Diamond + Sharpness 5 (via crates / enchanting) | $7000 | mid-late |
| Netherite | $35000 | late game |
| DragonScale (boss drop) | priceless | end-game |

Custom enchant scrolls (Lifesteal / Berserk / Vampire) are tradeable - their
auction house median price should land in the $3000-$10000 range.

## Tips for players

- Stay outside of spawn for at least 5 minutes after dying - back-spawning
  griefers is the most common newbie complaint.
- Place a `/sethome` *inside* your claim before going to PvP.
- The PvP world is a separate Multiverse world (recommended install) so PvP
  deaths don't drop your survival items.
- Combat tag means death on logout. Don't alt-F4 a losing fight.
