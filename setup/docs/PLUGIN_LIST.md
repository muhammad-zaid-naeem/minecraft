# Plugin List

All plugins that compose LifeSteal SMP. The "Installed" group is already
present in `plugins/`. The "Recommended" group needs to be installed for full
feature parity with the spec.

## Conventions

- MC: Paper 1.21.1
- Java: 21
- Drop jars directly into `plugins/`. Restart the server after each batch.

---

## Installed (already in `plugins/`)

### Core / Permissions / Economy

| Plugin | Version | Purpose | Link |
| --- | --- | --- | --- |
| Paper | 1.21.1 | Server software (root jar `paper-1.21.1.jar`) | https://papermc.io |
| LuckPerms | latest | Permissions / groups / prefixes | https://luckperms.net |
| Vault | latest | Economy / permission API bridge | https://www.spigotmc.org/resources/vault.34315/ |
| EssentialsX | latest | /home /sethome /tpa /back /spawn /msg /pay /balance | https://essentialsx.net |
| EssentialsX Chat | latest | Chat formatting (uses LuckPerms prefixes) | https://essentialsx.net |
| EssentialsX Spawn | latest | Spawn handling on join/respawn | https://essentialsx.net |

### Land / Anti-Grief / Security

| Plugin | Version | Purpose |
| --- | --- | --- |
| GriefPrevention | latest | Land claims + automatic anti-grief |
| GrimAC | 2.3.74 | Movement / combat anti-cheat |
| CombatLog+ | latest | Combat tag + kill on logout |
| CoreProtect-CE | 23.2 | Block + inventory + container logging, rollback |
| AdvancedBan | 2.3.0 | Bans, mutes, warns, kicks |
| DriveBackupV2 | latest | Scheduled Google Drive backups |

### Skills / Progression

| Plugin | Version | Purpose |
| --- | --- | --- |
| AuraSkills | 2.3.12 | 12 skills, levels, stats, leaderboards |
| Quests (Pikamug) | 5.3.1 | Daily quests, weekly challenges, battle pass |

### Economy / Shops / Crates

| Plugin | Version | Purpose |
| --- | --- | --- |
| EconomyShop GUI | 1.1.4 | Admin server shop (/shop) |
| QuickShop-Hikari | 6.2.0.11 | Chest-based player shops |
| ExcellentCrates | 6.6.1 | 5-tier crates, keys, animations |
| nuvotifier | latest | Receives vote callbacks from listing sites |

### Combat / Mobs / LifeSteal

| Plugin | Version | Purpose |
| --- | --- | --- |
| MythicMobs | 5.12.1 | Custom mobs, bosses, skills, loot |
| LifeStealZ | latest | Heart-on-kill / heart-loss-on-death |

### Community

| Plugin | Version | Purpose |
| --- | --- | --- |
| SimpleClans | latest | Clans, allies, KDR, clan chat |

### Chat / Cross-platform

| Plugin | Version | Purpose |
| --- | --- | --- |
| DiscordSRV | 1.30.5 | Two-way chat, link, channels, staff logs |
| ViaVersion | latest | Forward client version support |
| ViaBackwards | latest | Backward client version support (1.8+) |

### NPCs / Cosmetics

| Plugin | Version | Purpose |
| --- | --- | --- |
| ZNPCsPlus | 2.0.0 | Lightweight NPCs with click actions + holograms |
| DecentHolograms | 2.10.0 | Standalone floating-text holograms + leaderboards |
| PlayerParticles | 8.12 | Particle trails and cosmetic effects |

### Staff

| Plugin | Version | Purpose |
| --- | --- | --- |
| Staff+ | latest | Staff mode, vanish, freeze, examine |
| StaffPlus (config dir) | - | Companion config dir (already created) |

### Tooling

| Plugin | Version | Purpose |
| --- | --- | --- |
| PlaceholderAPI | 2.12.2 | Placeholder bridge for holograms / chat / scoreboards |
| FastAsyncWorldEdit | latest | World editing, schematic paste |

### UI / Tab + Scoreboard / Menus

| Plugin | Version | Purpose |
| --- | --- | --- |
| **TAB** (NEZNAMY) | 6.0.3 | Tab list header/footer, sidebar scoreboard, nametags, bossbar - all-in-one. Already installed at `plugins/TAB-6.0.3.jar`. See `setup/docs/TAB_SCOREBOARD.md`. |
| **DeluxeMenus** (HelpChat) | 1.14.1 | GUI menu system - main hub, warps, profile, shop, wild. Already installed at `plugins/DeluxeMenus-1.14.1.jar`. See `setup/docs/MENUS.md`. |

### World management

| Plugin | Version | Purpose |
| --- | --- | --- |
| **Multiverse-Core** | 5.7.0 | Multi-world support; the dedicated `wild` world for RTP. Already installed at `plugins/Multiverse-Core-5.7.0.jar`. See `setup/docs/WILD_WORLD.md`. |

---

## Recommended (install before going live)

These cover the gaps in the spec that the current plugin set does not fully
address. Drop them in `plugins/` and restart.

| Feature | Plugin | Why |
| --- | --- | --- |
| Vote rewards + leaderboard | **VotingPlugin** (BenCodez) | Best multi-site vote tracking + monthly top + bungee chains. Pairs with nuvotifier. |
| Auction house | **AuctionHouseReborn** or **AuctionGUIPlus** | The `/ah` GUI for player-driven auctions with Vault. |
| Daily login crate timer | (covered by ExcellentCrates) or **DailyRewards** | `/daily` claim flow if you want it separate from Crates. |
| Party system | **Parties** (AlessioDP) | `/party create`, /p chat, follow-leader. |
| Friends | **HuskHomes** or **DeluxeFriends** | `/friend add`, jump-to-friend. |
| Anti-bot login (cracked) | **LimboAuth** or **NLogin** | Required because `online-mode=false`. Filters bot floods + forces `/login`. |
| Region flags beyond GP | **WorldGuard** | PvP-only zones, command blocking, no-build zones at spawn. |
| Multi-world (PvP world, event world) | **Multiverse-Core** | Lets you keep PvP outside the survival world. |
| Custom enchants library | **EcoEnchants** | Drop-in 200+ enchants if you do not want to author your own via MythicMobs. |
| Custom items / textures | **ItemsAdder** or **Oraxen** | If you want a resource-pack-driven custom item set with custom textures. |
| Pets | **MyPet** or use MythicMobs friendlies | `/pet <type>` with proper AI. |
| Tickets | **DiscordTickets** (DiscordSRV addon) or **CMI tickets** | Player reports + staff replies. |
| Perf profiling | **Spark** | Already auto-installed by Paper; useful to keep visible. |
| Server-side helper | **ProtocolLib** | Required dependency for ProtocolLib-based plugins. Install if any plugin asks. |
| ChestSort | **ChestSort** | QoL inventory sorting. |

---

## Download sources

- spigotmc.org/resources/ - default for most listed plugins.
- modrinth.com - mirror for Paper, ViaVersion, QuickShop-Hikari, GrimAC, etc.
- builds.guizhanss.com or hangar.papermc.io - alternate mirrors.
- github.com/<author>/<plugin>/releases - source of truth for some (LuckPerms,
  DiscordSRV, DriveBackupV2, AdvancedBan, ZNPCsPlus, AuraSkills).

Always grab the version that targets MC 1.21.x.
