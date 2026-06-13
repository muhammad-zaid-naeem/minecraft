# Permissions

Catalog of every permission node used by LifeSteal SMP, grouped by plugin.
Apply via LuckPerms: `/lp group <rank> permission set <node> true`.

The complete rank-tree script is `setup/luckperms/ranks_setup.txt`.

## EssentialsX

| Node | Default rank | Description |
| --- | --- | --- |
| essentials.spawn | default | `/spawn` |
| essentials.help | default | `/help` |
| essentials.list | default | `/list` |
| essentials.rules | default | `/rules` |
| essentials.msg | default | `/msg <player> <text>` |
| essentials.r | default | `/r <text>` reply |
| essentials.mail | default | `/mail` |
| essentials.warp | default | base warp perm |
| essentials.warp.list | default | `/warps` |
| essentials.warps.spawn | default | `/warp spawn` |
| essentials.warps.pvp | default | `/warp pvp` |
| essentials.warps.bosses | default | `/warp bosses` |
| essentials.warps.info | default | `/warp info` |
| essentials.warps.store | default | `/warp store` |
| essentials.warps.tour | default | `/warp tour` |
| essentials.warps.market | default | `/warp market` |
| essentials.warps.events | default | `/warp events` |
| essentials.tpa | default | `/tpa` |
| essentials.tpaccept | default | `/tpaccept` |
| essentials.tpdeny | default | `/tpdeny` |
| essentials.tpacancel | default | `/tpacancel` |
| essentials.tpahere | default | `/tpahere` |
| essentials.back | default | `/back` |
| essentials.sethome | default | `/sethome` |
| essentials.home | default | `/home` |
| essentials.delhome | default | `/delhome` |
| essentials.sethome.multiple.vip | vip | up to 3 homes |
| essentials.sethome.multiple.mvp | mvp | up to 5 homes |
| essentials.sethome.multiple.elite | elite | up to 10 homes |
| essentials.balance | default | `/balance` |
| essentials.pay | default | `/pay` |
| essentials.afk | default | `/afk` |
| essentials.suicide | default | `/suicide` |
| essentials.workbench | default | `/wb` |
| essentials.echest | default | `/echest` (own) |
| essentials.rtp | default | `/rtp` |
| essentials.chat.color | vip | color codes in chat |
| essentials.chat.format | mvp | format codes |
| essentials.fly | vip | `/fly` |
| essentials.heal | mvp | `/heal` |
| essentials.god | elite | `/god` |
| essentials.feed | vip | `/feed` |
| essentials.nick | vip | `/nick` |
| essentials.repair | mvp | `/repair` |
| essentials.invsee | elite | `/invsee` |
| essentials.kit | default | `/kit` base |
| essentials.kit.vip | vip | kit vip |
| essentials.kit.mvp | mvp | kit mvp |
| essentials.kit.elite | elite | kit elite |
| essentials.kick | mod | `/kick` |
| essentials.mute | mod | `/mute` |
| essentials.tempmute | mod | `/tempmute` |
| essentials.warn | mod | `/warn` |
| essentials.tphere | mod | `/tphere` |
| essentials.vanish | mod | `/vanish` |
| essentials.* | admin | all Essentials |

## Vault

| Node | Default rank | Description |
| --- | --- | --- |
| vault.economy.balance | default | base economy access |
| vault.*  | admin | wildcard |

## GriefPrevention

| Node | Default rank | Description |
| --- | --- | --- |
| griefprevention.claim | default | claim land |
| griefprevention.claims | default | manage own claims |
| griefprevention.trust | default | trust other players |
| griefprevention.untrust | default | untrust |
| griefprevention.staff | mod | override claims for moderation |
| griefprevention.admin | admin | full admin |

## LuckPerms

| Node | Default rank | Description |
| --- | --- | --- |
| luckperms.editor | admin | `/lp editor` web link |
| luckperms.user.* | admin | manage users |
| luckperms.* | owner | wildcard |

## AuraSkills

| Node | Default rank | Description |
| --- | --- | --- |
| auraskills.command.skills | default | `/skills` |
| auraskills.command.stats | default | `/stats` |
| auraskills.command.top | default | `/skilltop` |
| auraskills.* | admin | full admin |

## Quests (Pikamug)

| Node | Default rank | Description |
| --- | --- | --- |
| quests.command.use | default | base |
| quests.quest | default | accept / drop quests |
| quests.questinfo | default | `/questinfo` |
| quests.admin | admin | edit quests in-game |

## SimpleClans

| Node | Default rank | Description |
| --- | --- | --- |
| simpleclans.member.* | default | all member commands |
| simpleclans.leader.* | (in clan) | inherited when promoted to leader |
| simpleclans.admin.* | admin | server-wide admin |

## QuickShop-Hikari

| Node | Default rank | Description |
| --- | --- | --- |
| quickshop.create.shop | default | create chest shop |
| quickshop.use | default | use shops |
| quickshop.commands.list | default | `/qs list` |
| quickshop.staff | mod | manage other players' shops |
| quickshop.admin | admin | wildcard |

## ExcellentCrates

| Node | Default rank | Description |
| --- | --- | --- |
| excellentcrates.player | default | open + preview |
| excellentcrates.admin | admin | full admin |

## PlayerParticles

| Node | Default rank | Description |
| --- | --- | --- |
| playerparticles.use | default | base |
| playerparticles.style | default | apply styles |
| playerparticles.particles.13 | vip | first unlock tier |
| playerparticles.particles.25 | mvp | second tier |
| playerparticles.particles.50 | elite | full unlock |

## DecentHolograms

DecentHolograms requires no viewer permission - everyone sees holograms.
Admin: `decentholograms.admin` (admin rank).

## ZNPCsPlus

| Node | Default rank | Description |
| --- | --- | --- |
| znpcsplus.* | admin | create / edit / delete NPCs |

## AdvancedBan

| Node | Default rank | Description |
| --- | --- | --- |
| advancedban.history | default | `/history` (own) |
| advancedban.warn | mod | `/warn` |
| advancedban.mute | mod | `/mute` |
| advancedban.ban | mod | `/ban` |
| advancedban.* | admin | wildcard |

## StaffPlus / Staff+

| Node | Default rank | Description |
| --- | --- | --- |
| staffplus.* | mod | staff mode + gadgets |
| staffplus.admin | admin | manage staff config |

## CoreProtect

| Node | Default rank | Description |
| --- | --- | --- |
| coreprotect.lookup | mod | `/co i`, `/co l` |
| coreprotect.inspect | mod | inspect mode |
| coreprotect.rollback | admin | `/co rollback` |
| coreprotect.* | admin | wildcard |

## DiscordSRV

| Node | Default rank | Description |
| --- | --- | --- |
| discordsrv.link | default | `/discord link` |
| discordsrv.staff | mod | view staff chat bridge |
| discordsrv.admin | admin | reload + config |

## FastAsyncWorldEdit

| Node | Default rank | Description |
| --- | --- | --- |
| worldedit.* | admin | base WE |
| fawe.* | admin | FAWE-specific |

## Wildcards

- `mod` permission set includes most moderation commands but NOT `*`.
- `admin` adds wildcard sets per plugin (`essentials.*`, `worldedit.*`, etc.).
- `owner` gets the universal wildcard `*`. Avoid using `owner` for routine work.

## Verifying permissions

```
/lp user <name> permission info
/lp user <name> permission check <node>
/lp group <rank> permission info
/lp verbose record on    (watch every perm check)
```
