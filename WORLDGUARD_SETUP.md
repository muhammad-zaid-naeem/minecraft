# WorldGuard – Spawn & Arena Protection Setup

**Server:** Paper 1.21.1 · **WorldGuard:** 7.0.12 (installed in `plugins/`) · uses FastAsyncWorldEdit (already installed).

Spawn point: `world` @ `x=0.5, y=104, z=0.5`

---

## Step 1 — Load the plugin
WorldGuard was just added to `plugins/`. **Restart the server** (do NOT `/reload` — it corrupts WorldEdit/WG state).

```
stop
```
…then start the server again. Confirm with:
```
/plugins        (WorldGuard + WorldEdit/FAWE should be green)
/wg version
```

You must be **OP** (or have `worldguard.*`) to run the commands below.

---

## Step 2 — Define the SPAWN region (no build, NO PvP)

Selection by exact coords (≈60×60 around spawn, full height). Run these in chat:
```
//pos1 -30,-64,-30
//pos2 30,320,30
/rg define spawn
```

Set the flags:
```
/rg flag spawn pvp deny
/rg flag spawn build deny
/rg flag spawn pvp deny
/rg flag spawn damage-animals deny
/rg flag spawn mob-spawning deny
/rg flag spawn tnt deny
/rg flag spawn fire-spread deny
/rg flag spawn greeting &aYou entered Spawn — Safe Zone (No PvP)
/rg flag spawn farewell &cYou left Spawn — PvP is ON!
/rg setpriority spawn 10
```

> `build deny` / `pvp deny` apply to normal players. **Staff who need to build** at spawn: give them bypass with `/lp group <staffgroup> permission set worldguard.region.bypass.world true`, or add them as region owners: `/rg addowner spawn <name>`.

---

## Step 3 — Define the ARENA region (no build, PvP ALLOWED)

Go to the arena. Either use coords like above, **or** use the wand:
```
//wand            (gives a wooden axe)
left-click  one corner
right-click the opposite corner
```
Then:
```
/rg define arena
/rg flag arena pvp allow
/rg flag arena build deny
/rg flag arena greeting &cEntering the Arena — FIGHT!
/rg flag arena farewell &7You left the Arena.
/rg setpriority arena 10
```

If your arena floor needs to survive but players should still throw pearls/place during fights, instead of `build deny` use:
```
/rg flag arena block-break deny
/rg flag arena block-place deny
```

---

## Step 4 — Verify
```
/rg list
/rg info spawn
/rg info arena
```
Stand inside each region and test: punching a block (should be blocked), and hitting another player (blocked in spawn, allowed in arena).

---

## Notes for THIS server
- **CombatLog+**: players can flee mid-fight into the no-PvP spawn. Check `plugins/CombatLogX/config.yml` for a "no-entry / punish on entering safezone (WorldGuard region) while tagged" option and enable it so spawn can't be used to escape combat.
- **LifeStealZ**: with `pvp deny` at spawn, no hearts are lost there — correct for a safe zone.
- Global `pvp=true` in `server.properties` stays as-is; WorldGuard region flags override it only inside spawn.
- Region data is saved in `plugins/WorldGuard/worlds/world/regions.yml`.
