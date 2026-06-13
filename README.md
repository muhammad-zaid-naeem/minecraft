# LifeSteal SMP - Production Minecraft Survival Server

A complete, production-ready Paper 1.21.1 Survival/LifeSteal network. Bundles
land claims, economy, quests, crates, custom bosses, clans, PvP, cosmetics, and
Discord integration.

- Engine: Paper 1.21.1 (`paper-1.21.1.jar`)
- Client support: 1.8.x - 1.21.x (via ViaVersion + ViaBackwards)
- Java: 21+
- RAM: 4 GB allocated (configurable in `start.bat`)
- Mode: Survival, hardcore-LifeSteal, cracked (`online-mode=false`)
- Default RCON: enabled on `:25575` (password in `server.properties`)

## Headline Features (player-facing)

1. Land claims + anti-grief (GriefPrevention) with auto-claim around new players.
2. Economy with Vault, server shop, player shops, auction house and daily rewards.
3. Quests, weekly challenges and a 100-tier seasonal Battle Pass.
4. Custom mobs, 5 named bosses, 5 crate tiers and a global event calendar.
5. Clans, parties, friends, ranks (default -> vip -> mvp -> elite) and cosmetic
   trails, pets and chat tags.

## Quick start

```
# Windows: just double-click start.bat (or run it from a terminal)
start.bat
```

Server listens on `:25565` by default. Stop with `stop` from the console.

## Documentation

All setup material lives in `setup/`. Start here:

- `setup/docs/SETUP_GUIDE.md` - top-to-bottom installation walkthrough.
- `setup/docs/PLUGIN_LIST.md` - every plugin used and where to source it.
- `setup/docs/FOLDER_STRUCTURE.md` - directory tree explanation.
- `setup/docs/RANKS.md` - rank ladder, perks and prices.
- `setup/docs/COMMANDS.md` - player + admin command reference.
- `setup/docs/PERMISSIONS.md` - permission node catalog by plugin.
- `setup/docs/SPAWN_LAYOUT.md` - spawn build map + NPC placement.
- `setup/docs/NPCS.md`, `setup/docs/CRATES.md`, `setup/docs/ECONOMY.md`,
  `setup/docs/PROGRESSION.md`, `setup/docs/PVP.md`, `setup/docs/COMMUNITY.md`,
  `setup/docs/COSMETICS.md`, `setup/docs/DISCORD.md`, `setup/docs/SECURITY.md`,
  `setup/docs/STAFF.md`, `setup/docs/EVENTS.md`,
  `setup/docs/TAB_SCOREBOARD.md` - topic-specific references.

## Setup scripts (paste into console)

- `setup/luckperms/ranks_setup.txt` - LuckPerms rank tree.
- `setup/npcs/spawn_npcs.txt` - 18 spawn NPCs (ZNPCsPlus).
- `setup/holograms/holograms_setup.txt` - DecentHolograms + leaderboards.
- `setup/crates/crates_setup.txt` - ExcellentCrates registration.
- `setup/warps/warps_setup.txt` - EssentialsX warps.
- `setup/economy/economyshop_seed.txt` - server shop catalog seed.

## Plugin configs

Template YAMLs to drop into each plugin's directory live under
`setup/configs/<plugin>/`. Each file starts with a `# DESTINATION:` header that
tells you where to copy it.

## Support

If you intend to run this in production, read `SETUP_GUIDE.md` end-to-end first.
The PvP and LifeSteal mechanics are not vanilla - players lose hearts on death
and gain hearts on kill.
