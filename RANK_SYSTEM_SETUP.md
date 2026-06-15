# LEGENDxPROs — Automatic Playtime Rank System

A two-plugin setup for **Paper 1.21.x** that:

- Gives **every new player the `Rookie` rank automatically** on first join.
- Automatically promotes a player to **`Survivor`** after **exactly 2 hours of total playtime**.
- Performs **no other automatic promotions**.
- Keeps **all staff ranks 100% manual** (they are not on the promotion track).

---

## 1. Plugins used (and why)

| Plugin | Role | 1.21.x | Status |
|---|---|---|---|
| **LuckPerms** | Permission groups, prefixes, the promotion track | ✅ | **Already installed** on your server |
| **PlayTimeManager** (by TheGaBr0) | Tracks total playtime and runs the promotion command at the 2h goal | ✅ (Paper 1.19 → latest) | **Needs installing** |
| PlaceholderAPI | Optional, used by PlayTimeManager for placeholders | ✅ | Already installed |

PlayTimeManager was built specifically to *"automatically execute a task such as promoting a player through LuckPerms"* when a playtime goal is reached — which is exactly this requirement. It tracks **total accumulated playtime**, so the 2-hour goal counts a player's lifetime time on the server, not a single session.

> Your server already has LuckPerms (H2 storage) and PlaceholderAPI, so the only new download is **PlayTimeManager**.

---

## 2. Install PlayTimeManager

1. Download the latest **PlayTimeManager** jar for Paper:
   - Hangar: <https://hangar.papermc.io/TheGabro/PlayTimeManager>
   - Modrinth: <https://modrinth.com/plugin/playtimemanager>
2. Drop the jar into `D:\minecraft\minecraft\plugins\`.
3. Restart the server (or run `/reload confirm` — a full restart is recommended).
4. Confirm it loaded: `/playtime` should return your own playtime.

---

## 3. LuckPerms — create the ranks & track

I've already added the **first-join auto-assignment** rule to your live config at
`plugins/LuckPerms/config.yml` (block titled *"LEGENDxPROs - Automatic Rank System"*):

```yaml
default-assignments:
  rookie-on-first-join:
    if:
      has-true: group.default
    take:
      - group.default
    give:
      - group.rookie
```

This means: any player who only has the built-in `default` group (i.e. a brand-new
player) is moved off `default` and given `rookie` on their first join.

Now create the groups and track. The full, ready-to-paste command list is in
**`setup/rank-system-luckperms-commands.txt`**. Paste it into the **server console**
one block at a time (or prefix each line with `/` if running in-game as OP). Summary:

```text
lp creategroup rookie
lp creategroup survivor
lp group rookie setweight 10
lp group survivor setweight 20
lp group rookie meta setprefix "&7[Rookie] "
lp group survivor meta setprefix "&a[Survivor] "
lp group survivor parent add rookie

# Promotion track contains ONLY rookie -> survivor (no further auto steps)
lp createtrack ranks
lp track ranks append rookie
lp track ranks append survivor

lp reload
```

Then reload so the `default-assignments` rule takes effect:

```text
/lp reload
```

> **Staff:** staff groups are **not** on the `ranks` track, so PlayTimeManager can
> never auto-promote anyone into or beyond them. Assign staff by hand with
> `lp user <name> parent set <staffgroup>` (using `set` cleanly removes
> rookie/survivor/default). The optional staff groups are at the bottom of the
> commands file.

---

## 4. PlayTimeManager — create the 2-hour promotion goal

PlayTimeManager goals are created with a command, then configured in a GUI.

**Step 1 — create the goal:**
```text
/playtimegoal create survivor_promotion
```

**Step 2 — open the goal editor and configure it:**
```text
/playtimegoal
```
In the GUI, click the `survivor_promotion` goal and set:

| Setting | Value |
|---|---|
| **Time requirement** | `2h`  (2 hours of total playtime) |
| **Active** | `true` |
| **Repeatable** | `false`  (one-time promotion) |
| **Goal message** | `&aCongratulations PLAYER_NAME, you've reached 2 hours and are now a &2Survivor&a!` |
| **Commands** (executed by console on completion) | see below |

**Commands to add to the goal** (the special placeholder `PLAYER_NAME` is replaced
with the player's name automatically):

```text
lp user PLAYER_NAME parent remove rookie
lp user PLAYER_NAME parent add survivor
```

That swap — remove `rookie`, add `survivor` — is the entire promotion. Because the
goal is **not repeatable** and `survivor` is the end of the track, no player is ever
promoted twice or beyond Survivor.

> **Alternative one-liner:** instead of the two commands above you can use the track:
> `lp user PLAYER_NAME promote ranks`. The explicit remove/add is preferred here
> because it is fully predictable regardless of any group the player already has.

**Step 3 — reload PlayTimeManager:**
```text
/playtimereload
```

When a player crosses 2 hours of total playtime, PlayTimeManager's completion check
fires the commands and they become a Survivor.

---

## 5. Verify it works

1. **New-player rank:** have a fresh account join → they should immediately have the
   `[Rookie]` prefix. Check with `/lp user <name> info` (primary group = `rookie`).
2. **Playtime read:** `/playtime <name>` shows accumulated time.
3. **Force the promotion (test):** temporarily set the goal time low, or run
   `/playtimegoal survivor_promotion checknow` after a test account passes 2h. The
   player's group should change to `survivor` and the prefix to `[Survivor]`.
4. **No double-promote:** the goal is one-time (`repeatable: false`), so it won't fire
   again, and Survivor is the last rank on the track — nothing auto-promotes past it.
5. **Staff untouched:** `lp user <staff> parent set moderator` — they keep their staff
   rank; the goal's remove/add only affects rookie→survivor.

---

## 6. How the pieces fit together

```
New player joins
      │
      ▼
LuckPerms default-assignments  ──►  player gets group "rookie"  (Rookie rank)
      │
      ▼
PlayTimeManager tracks total playtime
      │  (reaches exactly 2h)
      ▼
Goal "survivor_promotion" runs:
   lp user <player> parent remove rookie
   lp user <player> parent add survivor   ──►  player is now Survivor
      │
      ▼
No further automatic promotions. Staff = manual only.
```

---

## 7. Files created / changed

- `plugins/LuckPerms/config.yml` — added the `default-assignments` block (Rookie on first join).
- `setup/rank-system-luckperms-commands.txt` — copy-paste LuckPerms group/track/staff setup.
- `RANK_SYSTEM_SETUP.md` — this guide.

The PlayTimeManager goal is created at runtime via `/playtimegoal create` (it lives in
PlayTimeManager's own `goals` folder once the plugin is installed).
