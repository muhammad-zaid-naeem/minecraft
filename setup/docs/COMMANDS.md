# Command Reference

Player + admin command catalog, grouped by feature. Permissions are listed in
short form (see `PERMISSIONS.md` for full nodes).

## Teleport / Travel

| Command | Aliases | Description | Min rank |
| --- | --- | --- | --- |
| `/spawn` | | Teleport to spawn | default |
| `/sethome [name]` | | Save your current location | default |
| `/home [name]` | `/homes` | Teleport to a saved home | default |
| `/delhome <name>` | | Delete a home | default |
| `/back` | | Return to last death / TP | default |
| `/rtp` | `/wild` | Random teleport into the wild | default |
| `/tpa <player>` | | Request to TP TO a player | default |
| `/tpahere <player>` | | Request a player to come to you | default |
| `/tpaccept` | | Accept a pending request | default |
| `/tpdeny` | | Deny a pending request | default |
| `/warp <name>` | | Teleport to a warp | default |
| `/warps` | | List all warps | default |

## Land Claims (GriefPrevention)

| Command | Description | Min rank |
| --- | --- | --- |
| `/claim` | Auto-claim around you | default |
| `/abandonclaim` | Remove the claim you stand in | default |
| `/abandonallclaims` | Remove all your claims | default |
| `/trust <player>` | Grant build access | default |
| `/untrust <player>` | Revoke access | default |
| `/containertrust <player>` | Only allow chest access | default |
| `/accesstrust <player>` | Only allow doors / buttons | default |
| `/permissiontrust <player>` | Allow trust managing | default |
| `/trustlist` | View who has access | default |
| `/claimexplosions` | Toggle explosion damage in your claim | default |
| `/claimslist [player]` | List claims | default |

## Economy

| Command | Description | Min rank |
| --- | --- | --- |
| `/balance` `/bal` | Your money | default |
| `/balance <player>` | Inspect another | default |
| `/pay <player> <amount>` | Transfer money | default |
| `/baltop` | Top balances | default |
| `/eco give <player> <amt>` | Give money | admin |
| `/eco take <player> <amt>` | Remove money | admin |
| `/eco set <player> <amt>` | Force set | admin |

## Server Shop (EconomyShop GUI)

| Command | Description | Min rank |
| --- | --- | --- |
| `/shop` | Open the shop GUI | default |
| `/eshop create <category>` | New category | admin |
| `/eshop additem <cat> <mat> <buy> <sell>` | Add an item | admin |
| `/eshop removeitem <cat> <mat>` | Remove | admin |
| `/eshop reload` | Reload yml configs | admin |

## Player Shops (QuickShop-Hikari)

| Command | Description | Min rank |
| --- | --- | --- |
| `/qs create <price>` | Mark a chest as a shop (you must be looking at it) | default |
| `/qs remove` | Remove your shop | default |
| `/qs list` | All shops on the server | default |
| `/qs find <item>` | Find a player selling X | default |
| `/qs tax` | Show server tax % | default |
| `/qs reload` | Reload | admin |

## Auction House

| Command | Description | Min rank |
| --- | --- | --- |
| `/ah` | Open AH GUI | default |
| `/ah sell <price>` | List held item | default |
| `/ah cancel <id>` | Pull a listing | default |
| `/ah history` | Past sales | default |

## Crates (ExcellentCrates)

| Command | Description | Min rank |
| --- | --- | --- |
| `/crate menu` | GUI of all crates | default |
| `/crate preview <id>` | Inspect rewards | default |
| `/crate open <id>` | Force open | default |
| `/crate key give <player> <id> <n>` | Give keys | admin |
| `/crate key giveall <id> <n>` | Give to everyone online | admin |
| `/crate giveall <id> <n>` | Give the crate item | admin |
| `/crate reload` | Reload | admin |

## Quests / Battle Pass

| Command | Description | Min rank |
| --- | --- | --- |
| `/quests gui` | Open quest GUI | default |
| `/questinfo <id>` | Show quest details | default |
| `/quest <id>` | Accept | default |
| `/questadmin` | Admin GUI | admin |
| `/battlepass` | Open BP GUI | default |

## Skills (AuraSkills)

| Command | Description | Min rank |
| --- | --- | --- |
| `/skills` | Open skill GUI | default |
| `/stats` | View your stats | default |
| `/skilltop [skill]` | Leaderboard | default |
| `/skillsadmin` | Admin tools | admin |

## Clans (SimpleClans)

| Command | Description | Min rank |
| --- | --- | --- |
| `/clan` | Help menu | default |
| `/clan create <tag> <name>` | Create a clan | default |
| `/clan invite <player>` | Invite | default |
| `/clan accept` | Accept | default |
| `/clan leave` | Leave | default |
| `/clan kick <player>` | Leader only | default |
| `/clan ally <clan>` | Propose alliance | default |
| `/clan war <clan>` | Declare war | default |
| `/clan chat <msg>` | `/clan.` Clan chat | default |
| `/ally chat <msg>` | Allies-only chat | default |

## PvP

| Command | Description | Min rank |
| --- | --- | --- |
| `/warp pvp` | Enter PvP arena | default |
| `/duel <player>` | Challenge | default |
| `/pvplog` | Disclaimer page | default |

## Cosmetics

| Command | Description | Min rank |
| --- | --- | --- |
| `/pp gui` | Particles GUI | default |
| `/pp toggle` | On / off | default |
| `/pet <type>` | Spawn a pet (recommended MyPet) | varies |
| `/tag set <name>` | Apply a chat tag suffix | varies |

## Communication

| Command | Description | Min rank |
| --- | --- | --- |
| `/msg <p> <text>` | DM | default |
| `/r <text>` | Reply | default |
| `/mail send <p> <text>` | Mail | default |
| `/mail read` | Read inbox | default |
| `/me <text>` | Action message | default |
| `/afk` | Toggle AFK | default |
| `/discord link` | Link Discord acct | default |
| `/discord` | Show invite | default |
| `/sc <text>` | Staff chat | mod |

## Cosmetic Names

| Command | Description | Min rank |
| --- | --- | --- |
| `/nick <name>` | Set nickname | vip |
| `/nick off` | Clear | vip |
| `/realname <nick>` | Reveal | default |

## Staff Mode (StaffPlus)

| Command | Description | Min rank |
| --- | --- | --- |
| `/sm` | Toggle staff mode | mod |
| `/vanish` `/v` | Toggle vanish | mod |
| `/freeze <player>` | Freeze | mod |
| `/examine <player>` | Inspect inventory | mod |
| `/staffchat` `/sc` | Staff chat | mod |

## Moderation

| Command | Description | Min rank |
| --- | --- | --- |
| `/warn <p> <reason>` | Warn | mod |
| `/kick <p> <reason>` | Kick | mod |
| `/mute <p> <reason>` | Permanent mute | mod |
| `/tempmute <p> <time> <reason>` | Time mute | mod |
| `/unmute <p>` | Unmute | mod |
| `/ban <p> <reason>` | Ban | mod |
| `/tempban <p> <time> <reason>` | Tempban | mod |
| `/unban <p>` | Unban | mod |
| `/history <p>` | View history | mod |
| `/report <p> <reason>` | Player report | default |

## CoreProtect

| Command | Description | Min rank |
| --- | --- | --- |
| `/co inspect` `/co i` | Toggle inspector | mod |
| `/co lookup <args>` `/co l` | Lookup | mod |
| `/co rollback u:<p> t:<time> r:<r>` | Rollback | admin |
| `/co restore u:<p> t:<time> r:<r>` | Restore after rollback | admin |
| `/co purge t:<time>` | Purge old logs | admin |

## NPC Admin (ZNPCsPlus)

| Command | Description | Min rank |
| --- | --- | --- |
| `/npc create <id> PLAYER <world> <x> <y> <z>` | Create | admin |
| `/npc skin set <id> <name>` | Set skin | admin |
| `/npc holo add <id> "<text>"` | Add line | admin |
| `/npc action add <id> RUN_COMMAND "<cmd>"` | Add click action | admin |
| `/npc move <id>` | Move to your location | admin |
| `/npc delete <id>` | Delete | admin |
| `/npc list` | List | admin |
| `/npc near <radius>` | List nearby | admin |

## Hologram Admin (DecentHolograms)

| Command | Description | Min rank |
| --- | --- | --- |
| `/dh create <name> <x> <y> <z>` | Create | admin |
| `/dh line add <name> "<text>"` | Add line | admin |
| `/dh line set <name> <idx> "<text>"` | Edit line | admin |
| `/dh setrange <name> <blocks>` | Render distance | admin |
| `/dh setupdateinterval <name> <ticks>` | Refresh rate | admin |
| `/dh move <name>` | Move to your location | admin |
| `/dh delete <name>` | Delete | admin |
| `/dh list` | List | admin |

## Server / World Admin

| Command | Description | Min rank |
| --- | --- | --- |
| `/lp <args>` | LuckPerms | admin |
| `/save-all` | Force save | mod |
| `/save-off`, `/save-on` | Toggle saves | admin |
| `/restart` | Graceful restart | admin |
| `/stop` | Stop server | admin |
| `/reload confirm` | Hot reload (AVOID in prod) | owner |
| `/tps` | TPS report | mod |
| `/spark profiler` | Profile | admin |
| `/spark heapsummary` | Heap | admin |
| `/drivebackup nextbackup` | Next backup | admin |
| `/drivebackup forcebackup` | Force a backup now | admin |
| `/drivebackup linkaccount googledrive` | Link cloud account | admin |
| `/mm reload` | Reload MythicMobs | admin |
| `/mm m spawn <id> <amt>` | Spawn boss/mob | admin |
| `/mm i give <id>` | Give MM item | admin |
| `/fawe paste <schematic>` | Paste schematic | admin |
| `/whitelist <add|remove|on|off> [player]` | Whitelist | admin |

## Quick wins (memorise these)

- `/spawn` - get home base.
- `/sethome` + `/home` - mark and return.
- `/rtp` - jump into the wild.
- `/shop` - buy / sell.
- `/ah` - auction house.
- `/quests gui` - daily / weekly.
- `/skills` - your levels.
- `/crate menu` - your keys.
- `/clan` - clan menu.
- `/pp gui` - particles.
- `/msg <p> <text>` - DM.
- `/discord link` - bridge to Discord.
