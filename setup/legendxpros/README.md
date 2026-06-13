# LEGENDxPROs — TAB · Scoreboard · Rank System

Complete, ready-to-paste setup for a **Paper 1.21.x** Survival + Custom Bosses server.

> **Good news:** your server (`D:\minecraft\minecraft`) already has every required plugin
> installed. Configs in this folder were written against your **actual TAB 6.0.3** files,
> so they paste in with **zero edits** (just change the domain/Discord text to yours).

---

## 1. Required plugins & why

| Plugin | Status on your server | Why it's needed |
|---|---|---|
| **TAB** (6.0.3) | ✅ installed | The engine for the tablist, animated header/footer, nametag sorting, bossbar **and** the sidebar scoreboard. One plugin does all of it. |
| **LuckPerms** | ✅ installed | Rank hierarchy, group weights, inheritance, prefixes/suffixes, promotion tracks. The single source of truth for ranks. |
| **PlaceholderAPI** | ✅ installed | Bridges data (money, kills, ping, playtime…) from other plugins into TAB/holograms via `%placeholders%`. |
| **Vault** | ✅ installed | Standard economy/permissions bridge. Lets PlaceholderAPI read balances (`%vault_eco_balance%`). |
| **EssentialsX** | ✅ installed | Economy provider (the `$` balance), homes, spawn, kits, chat. Feeds Vault. |
| **DecentHolograms** | ✅ installed | Floating text holograms (spawn welcome board, boss-kill leaderboards). |
| **MythicMobs** | ✅ installed | Your **custom bosses**. Also powers the boss-kill counter (see §10). |
| **LifeStealZ** | ✅ installed | Heart-stealing PvP — pairs with the Kills/Deaths scoreboard stats. |
| **ZNPCsPlus** | ✅ installed | NPCs (the "Citizens" role). Lighter, 1.21-ready alternative to Citizens. |

**Optional / alternatives mentioned:**
- **Citizens** — NPC plugin. You already run **ZNPCsPlus** which fills the same role, so Citizens is *not* needed.
- **FancyHolograms** — modern alternative to DecentHolograms (uses server-side display entities, no packets). You already run DecentHolograms; only switch if you want display-entity holograms.
- **BetterRTP** — random-teleport for survival. Nice-to-have, not part of the TAB/rank system.

### Download links (only if reinstalling)
- TAB → https://www.spigotmc.org/resources/57806/ (or GitHub: NEZNAMY/TAB releases)
- LuckPerms → https://luckperms.net/download
- PlaceholderAPI → https://www.spigotmc.org/resources/6245/
- Vault → https://www.spigotmc.org/resources/34315/
- EssentialsX → https://essentialsx.net/downloads.html
- DecentHolograms → https://www.spigotmc.org/resources/96927/
- MythicMobs → https://www.spigotmc.org/resources/5702/
- FancyHolograms (alt) → https://modrinth.com/plugin/fancyholograms
- Citizens (optional) → https://www.spigotmc.org/resources/13811/
- BetterRTP (optional) → https://www.spigotmc.org/resources/61327/

---

## 2. Folder structure (where each file goes)

```
D:\minecraft\minecraft\
├── plugins\
│   ├── TAB\
│   │   ├── config.yml          ← REPLACE with setup\legendxpros\TAB\config.yml
│   │   ├── animations.yml      ← REPLACE with setup\legendxpros\TAB\animations.yml
│   │   ├── groups.yml          ← REPLACE with setup\legendxpros\TAB\groups.yml
│   │   ├── users.yml           (leave as-is)
│   │   └── messages.yml        (leave as-is)
│   │
│   ├── LuckPerms\
│   │   └── config.yml          (optional edit for §9 auto-rookie — see luckperms-setup.txt)
│   │
│   ├── PlaceholderAPI\
│   │   └── expansions\         ← expansions land here after /papi ecloud download (see §3)
│   │
│   └── MythicMobs\
│       ├── Skills\
│       │   └── BossKillTracker.yml  ← COPY from setup\legendxpros\MythicMobs\
│       └── Mobs\                    (add the onDeath line to your boss files — see §10)
│
└── setup\legendxpros\          ← this staging folder (the files I generated)
    ├── README.md
    ├── luckperms-setup.txt
    ├── TAB\{config.yml, animations.yml, groups.yml}
    └── MythicMobs\BossKillTracker.yml
```

> **Note on “scoreboards.yml”:** TAB does **not** use a separate `scoreboards.yml`. In TAB 4.x–6.x
> the scoreboard lives inside `config.yml` under the `scoreboard:` section. It's fully built out
> there for you (see §6). That is the correct, current location for your TAB version.

---

## 3. PlaceholderAPI expansions required

Run these in console (they download into `plugins/PlaceholderAPI/expansions/`):

```
papi ecloud download Player
papi ecloud download Vault
papi ecloud download Statistic
papi ecloud download Server
papi reload
```

| Expansion | Provides (used in this setup) |
|---|---|
| **LuckPerms** | `%luckperms_prefix%`, `%luckperms_suffix%` — *auto-registered, no download* |
| **Vault** | `%vault_eco_balance_formatted%` (money) |
| **Statistic** | `%statistic_player_kills%`, `%statistic_deaths%`, `%statistic_time_played%`, `%statistic_mob_kills%` |
| **Player** | `%player_health%` (belowname health) |
| **Server** | `%server_tps%`, `%server_max_players%` (optional extras) |
| EssentialsX | `%essentials_*%` — *auto-registered when Essentials + PAPI are both present* |

> TAB also ships its **own** built-in placeholders that need **no** PAPI: `%player%`, `%online%`,
> `%staffonline%`, `%ping%`, `%tps%`, `%world%`, `%time%`, `%date%`. These are used in the
> header/footer so it works even before the ecloud downloads finish.

---

## 4. Installation guide (step by step)

1. **Stop the server.**
2. **Copy the TAB files** from `setup\legendxpros\TAB\` over the live ones in `plugins\TAB\`
   (config.yml, animations.yml, groups.yml). Back up the originals first if you want.
3. **Copy** `setup\legendxpros\MythicMobs\BossKillTracker.yml` → `plugins\MythicMobs\Skills\`.
4. **Edit the branding** (do once): in `TAB\config.yml` and `animations.yml`, replace
   `play.legendxpros.net`, `store.legendxpros.net`, `discord.gg/legendxpros` with your real links.
5. **Start the server.**
6. **Download PAPI expansions** (§3), then `papi reload`.
7. **Create the boss counter** (once): `scoreboard objectives add bosskills dummy "Boss Kills"`
8. **Run the LuckPerms setup** — paste the blocks from `luckperms-setup.txt` into console (§5/§7/§8).
9. **Apply:** `lp reload` then `tab reload`.
10. **Verify:** press TAB (header/footer + sorted ranks), look right (sidebar scoreboard).
    `lp user <you> parent set founder` to test the top rank.

---

## 5. LuckPerms setup commands

The full, copy-paste-ready command list is in **`luckperms-setup.txt`** (12 groups, weights,
prefixes, suffixes, inheritance, starter permissions, the `ranks` promotion track, and
auto-assigning new players to Rookie). Quick reference for daily use:

```
lp user <player> parent set helper        # set rank directly
lp user <player> promote ranks            # move up one rank
lp user <player> demote ranks             # move down one rank
lp user <player> parent addtemp legendplus 30d   # timed donor rank
lp reload  &&  tab reload
```

---

## 6. Scoreboard (MMORPG-style sidebar)

Built into `TAB/config.yml` under `scoreboard:`. Two versions auto-switch by client version:

- `legend-modern` — for 1.20.3+ clients (full-length lines)
- `legend-legacy` — for 1.8–1.20.2 clients (kept short for the old width limit)

It displays exactly what you asked for:

```
        LEGENDxPROS              ← animated title
─────────────────
● Player » Steve
● Rank   » [💎 Helper]
● Money  » $12.4K
⚔ COMBAT
● Kills      » 142
● Deaths     » 37
● Boss Kills » 9
❖ SERVER
● Online   » 48
● Ping     » 23ms
● Playtime » 3d 4h
─────────────────
play.legendxpros.net
discord.gg/legendxpros
```

Players can hide/show it with `/sb`.

---

## 7. TAB list & animated header/footer

`TAB/config.yml` is configured to:
- **Sort by rank automatically** — `sorting-types: GROUPS:founder,ceo,…,rookie` (top rank first).
- **Show prefixes** — pulled from LuckPerms via `groups.yml` (`%luckperms_prefix%`).
- **Show ping** — `playerlist-objective` renders ping next to every player.
- **Show online count** — in the header (`%online%`) and a live staff count (`%staffonline%`).
- **Animated branding** — `%animation:Brand%` (color-sweep "LEGENDxPROS") in the header, the
  bossbar, and the scoreboard title; `%animation:Store%` scrolls your store link in the footer.

Animations live in `TAB/animations.yml`: `Brand`, `Store`, `BarColors`, `Pulse`.

---

## 8. Rank hierarchy, prefixes & colors

| Rank | LP group | Weight | Prefix (legacy codes) | Accent |
|---|---|---|---|---|
| 👑 Founder | `founder` | 1000 | `&8[&4&l👑 Founder&8] &4` | dark red |
| 🚀 CEO | `ceo` | 900 | `&8[&c&l🚀 CEO&8] &c` | red |
| ⚙ CTO | `cto` | 800 | `&8[&6&l⚙ CTO&8] &6` | gold |
| 💻 LeadDev | `leaddev` | 700 | `&8[&e&l💻 LeadDev&8] &e` | yellow |
| 🛠 Developer | `developer` | 600 | `&8[&2&l🛠 Developer&8] &2` | dark green |
| 🛡 Admin | `admin` | 500 | `&8[&4&l🛡 Admin&8] &c` | red |
| 🎯 Moderator | `moderator` | 400 | `&8[&9&l🎯 Mod&8] &9` | blue |
| 💎 Helper | `helper` | 300 | `&8[&b&l💎 Helper&8] &b` | aqua |
| 🔥 Legend+ | `legendplus` | 200 | `&8[&d&l🔥 Legend+&8] &d` | light purple |
| ⭐ Legend | `legend` | 150 | `&8[&5&l⭐ Legend&8] &5` | purple |
| 👤 Survivor | `survivor` | 100 | `&8[&7👤 Survivor&8] &7` | gray |
| 🌱 Rookie | `rookie` | 50 | `&8[&8🌱 Rookie&8] &7` | dark gray |

> **Emoji rendering:** the crown/rocket/etc. only display if the player's client has an emoji
> font or resource pack (e.g. some launchers/packs add them). On vanilla clients they appear as
> a small box `▯`. **Colors and the `[Rank]` text always render correctly.** If you want them to
> render for everyone, ship a resource pack that maps those glyphs — or drop the emoji from the
> prefix in `luckperms-setup.txt`.

---

## 9. Animated server header/footer

Already wired in §7. The header shows the animated `LEGENDxPROS` brand + live online/staff
counts; the footer shows your ping, TPS, the scrolling store link, and Discord. Tune the speed
with `change-interval` (milliseconds) in `animations.yml`.

---

## 10. Custom boss statistics (Boss Kills)

Vanilla statistics **cannot** count custom MythicMobs bosses, so we keep a dedicated per-player
counter in a scoreboard objective named `bosskills`.

**Setup (once):**
```
scoreboard objectives add bosskills dummy "Boss Kills"
```
**Counting:** `MythicMobs/Skills/BossKillTracker.yml` (provided) increments it for the killer.
Add this one line to each boss in `plugins/MythicMobs/Mobs/<boss>.yml`:
```yaml
    Skills:
    - skill{s=TrackBossKill} @trigger ~onDeath
```
That's the reliable, persistent count. It instantly works for in-game messages
(`<trigger.score.bosskills>`), `/scoreboard` sidebars, holograms, leaderboards and rewards.

**Displaying it on the TAB scoreboard (`%bosskills%`):** ⚠️ honest caveat — PlaceholderAPI has
**no built-in expansion that reads a raw scoreboard objective**, so `%bosskills%` will not resolve
on its own. Pick one:

- **A — keep it simple (no edit needed):** leave the count for the in-game boss message + a
  `/scoreboard` or DecentHolograms leaderboard, and on the TAB sidebar swap the Boss Kills line to
  a guaranteed placeholder. Replace in `config.yml`:
  `"&7● &fBoss Kills &8» &d%bosskills%"` → `"&7● &fMob Kills &8» &d%statistic_mob_kills%"`
- **B — true boss-only on the sidebar:** install a small PAPI expansion that exposes scoreboard
  objectives as placeholders (search the ecloud for an "objective"/"scoreboard score" expansion),
  then map it so `%bosskills%` returns the objective value. After `papi reload`, the provided
  scoreboard line works as-is.

> I left `%bosskills%` in the config so option B is plug-and-play, and documented option A so you're
> never stuck with a blank line. This is the one field that isn't truly zero-config — everything
> else pastes in and works immediately.

---

## Holograms (DecentHolograms) — quick starts

Spawn welcome board (stand where you want it):
```
dh create welcome
dh line add welcome %animation_is_not_here%   # (DH has its own animations)
dh line add welcome &b&lLEGEND&f&lxPROS
dh line add welcome &7Welcome to the realm!
dh line add welcome &fOnline&8: &a%online%
```
Boss-kill leaderboard line (uses the objective from §10 once a leaderboard placeholder is set up):
```
dh create bosstop
dh line add bosstop &d&l⚔ TOP BOSS SLAYERS
dh line add bosstop &e#1 &f%...top placeholder...%
```

---

### Final apply
```
lp reload
tab reload
papi reload
```
Press **TAB** and look to the **right** of your screen. 🎉
