# Economy

The economy stack:

- **Vault** is the bridge plugin (no economy of its own).
- **EssentialsX** is the active economy provider (Vault picks it up).
- Currency symbol: `$`, name: "dollar" / "dollars".
- Starting balance: **$500** (set in `setup/configs/essentials/config.yml`).
- Max balance: 10,000,000,000 (10 B).

## Player commands

| Command | Purpose |
| --- | --- |
| `/balance` `/bal` | Your current balance |
| `/balance <player>` | Inspect another |
| `/pay <player> <amount>` | Transfer money |
| `/baltop` | Top 20 balances |
| `/shop` | Open server shop GUI |
| `/ah` | Auction house |
| `/qs find <item>` | Find player shops selling an item |
| `/crate menu` | Spend keys for loot |

## Server Shop (EconomyShop GUI)

- Plugin: **EconomyShop 1.1.4**.
- Command: `/shop`.
- Categories: Blocks, Tools, Combat, Food, Special (seeded by
  `setup/economy/economyshop_seed.txt`).
- Buy and sell are separate prices; sell is roughly 30-50% of buy.

### Sample prices

| Item | Buy | Sell |
| --- | --- | --- |
| DIRT | $1 | $0.1 |
| OAK_LOG | $5 | $2 |
| IRON_INGOT | $50 | $25 |
| GOLD_INGOT | $80 | $40 |
| DIAMOND | $300 | $150 |
| EMERALD | $200 | $100 |
| NETHERITE_INGOT | $1500 | $750 |
| IRON_PICKAXE | $200 | $75 |
| DIAMOND_PICKAXE | $800 | $300 |
| NETHERITE_PICKAXE | $5000 | $1500 |
| DIAMOND_SWORD | $1000 | $400 |
| NETHERITE_SWORD | $6000 | $2000 |
| GOLDEN_APPLE | $200 | $75 |
| ENCHANTED_GOLDEN_APPLE | $2000 | $600 |
| TOTEM_OF_UNDYING | $5000 | $1500 |
| ELYTRA | $10000 | $3000 |
| NETHER_STAR | $8000 | $2500 |
| BEACON | $12000 | $4000 |
| DRAGON_HEAD | $15000 | $5000 |

Full list in `setup/economy/economyshop_seed.txt`.

## Player Shops (QuickShop-Hikari)

- Plugin: **QuickShop-Hikari 6.2.0.11**.
- Tax: 5% to the server (sink).
- Create:
  1. Place a chest.
  2. Hold the item you want to sell.
  3. Left-click the chest.
  4. Type the price in chat.
- Cost to create: $20.
- Limit per rank: default 3, vip 10, mvp 20, elite 50.
- Browse: `/qs find <item>`, `/qs list`.
- Recommended market plot: `/warp market` (100, 70, 100) - have players rent
  plots, build stalls, and stack chest shops.

## Auction House

- Recommended plugin: **AuctionHouseReborn** (see PLUGIN_LIST.md - install
  before going live; not bundled).
- Player commands: `/ah`, `/ah sell <price>`, `/ah cancel <id>`,
  `/ah history`.
- Listing duration: 48h. Tax: 5% on successful sale.
- Suggested max listings per rank:
  - default: 3
  - vip: 5
  - mvp: 8
  - elite: 12
- Listing fee: 1% of price (minimum $10) up-front (sink).

## Daily Rewards

- Source: **ExcellentCrates** `daily` crate, plus **Quests** daily quests.
- Player runs `/crate preview daily` to see the day's loot, then opens the
  Daily Crate chest at spawn (-2, 101, -7).
- Daily crate key auto-given every 24h by a scheduled task (cron in
  ExcellentCrates yml).
- Sample daily rewards: 30% money ($100-500), 20% food, 15% basic gear,
  25% crate keys, 10% rare key.

## Vote Rewards

- nuvotifier listens on TCP `:8192`. Register the public key at each voting
  site (minecraft-mp.com, planetminecraft.com, etc.).
- VotingPlugin (recommended) gives every vote: **$50 + 1 Vote Key**.
- Monthly top voters: rank #1 gets a Legendary Key + $25000; #2-3 get an Epic
  Key + $10000; #4-10 each get a Rare Key + $5000.
- Leaderboard hologram lives at `(-15, 103, 0)`.

## Money sinks

To prevent inflation, money flows out via:

| Sink | Outflow |
| --- | --- |
| Server shop buy prices | up to ~50% of total flow |
| `/qs` shop tax | 5% on every player shop sale |
| `/ah` listing fee + tax | 1% list + 5% sale |
| Crate keys (rare/epic/legendary) | from server shop $500/$2500/$10000 |
| `/sethome` slots (rank purchase) | one-time |
| Cosmetics (particles, tags) | one-time per item |
| `/repair` (cooldown still applies for mvp+) | small fee per use |

Total recommended target: 30-40% of generated money goes to sinks weekly.

## Top earners

`/baltop` lists the top 20.  The leaderboard hologram updates every 5 seconds
via PlaceholderAPI `%vault_eco_top_balance_<n>_name%` and
`%vault_eco_top_balance_<n>_balance%`.

## Admin commands

| Command | Purpose |
| --- | --- |
| `/eco give <p> <amt>` | Mint money (avoid - prefer crate / quest reward) |
| `/eco take <p> <amt>` | Sink money |
| `/eco set <p> <amt>` | Force set |
| `/eco reset <p>` | Reset to starting balance |

## Inflation watchdog

Check the total money supply periodically:

```
/baltop                       # top players
/co lookup u:#economyshop t:7d r:300   # last 7d shop activity
```

If the top 10 balances exceed 10x the median balance, tighten sinks (raise
shop tax, raise listing fees, lower rare-key sell value).
