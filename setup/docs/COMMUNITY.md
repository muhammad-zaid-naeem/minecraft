# Community

## Clans (SimpleClans)

| Command | Description |
| --- | --- |
| `/clan create <tag> <name>` | Create a clan. Cost: $10000. |
| `/clan invite <player>` | Invite a player |
| `/clan accept` | Accept an invitation |
| `/clan kick <player>` | Leader only - kick member |
| `/clan promote <player>` | Promote to clan officer |
| `/clan demote <player>` | Demote officer |
| `/clan leave` | Leave the clan |
| `/clan disband` | Leader only - close clan |
| `/clan ally <clan>` | Propose alliance |
| `/clan war <clan>` | Declare war (PvP buff: +20% dmg vs enemy clan) |
| `/clan chat <msg>` | Clan-only chat (or just `/.`) |
| `/ally chat <msg>` | Allies-only chat (or `+`) |
| `/clan stats` | Your stats: KDR, kills, deaths, ranking |
| `/clan top` | Top 10 clans |

Clans cost $10000 to create. Tag length 2-5 chars. Members carry the tag in
chat via prefix injection. Inter-clan war flags 24h cooldown between declarations.

Leaderboards on `/clan top` are based on KDR + total kills.

## Friends

Recommended plugin: **HuskHomes** or **DeluxeFriends** (see PLUGIN_LIST.md).

Stub commands once installed:

| Command | Description |
| --- | --- |
| `/friend add <player>` | Send friend request |
| `/friend accept <player>` | Accept |
| `/friend remove <player>` | Remove |
| `/friend list` | List friends |
| `/friend tp <player>` | Jump to friend |
| `/friend toggle` | Allow/deny incoming requests |

Without a friends plugin you can use Essentials kits + permissions to mimic the
behaviour, or grant `essentials.tpa` + `essentials.tpaccept` (already in default).

## Party (Parties)

Recommended plugin: **Parties** (AlessioDP). Once installed:

| Command | Description |
| --- | --- |
| `/party create <name>` | Make a party |
| `/party invite <player>` | Invite |
| `/party accept <party>` | Accept |
| `/party leave` | Leave |
| `/party kick <player>` | Leader only |
| `/party chat` | Toggle party chat |
| `/party follow` | Toggle auto-follow leader |
| `/party home` | TP to party leader |
| `/party warp <name>` | TP party to a warp |

Party size cap: 8.

## Private Messages

EssentialsX `/msg`:

| Command | Description |
| --- | --- |
| `/msg <player> <text>` | DM |
| `/r <text>` | Reply to last DM |
| `/mail send <player> <text>` | Offline mail |
| `/mail read` | Read inbox |
| `/mail clear` | Clear |
| `/socialspy` | Staff command to see DMs |
| `/ignore <player>` | Block DMs from someone |

## Global Chat

Format (set in `plugins/Essentials/config.yml`):

```
{PREFIX} {DISPLAYNAME}: {MESSAGE}
```

- Prefix is taken from LuckPerms (`/lp user X meta setprefix`).
- Display name is your nick (if set via `/nick`) or your real name.
- Colour codes (`&` style) only allowed for `vip+`.
- Hex codes (`&#RRGGBB`) only allowed for `mvp+`.

Anti-spam: 1 message per 1.5 seconds (config in EssentialsX antibuild).

## Staff Chat

- Toggle: `/sc` (or `/staffchat`).
- One-off: `/sc <text>` (without toggling).
- Prefix in Discord: `[STAFF]`.
- Visible to: `mod`, `admin`, `owner` (perm: `essentials.chat.staff` and/or
  `staffplus.chat`).
- Bridge: DiscordSRV mirrors to the configured Discord staff channel.

## Server-wide announcements

| Command | Description | Min rank |
| --- | --- | --- |
| `/broadcast <msg>` | Yellow chat broadcast | mod |
| `/announce <msg>` | Title + chat + sound | admin |
| `/me <text>` | Action chat | default |

## Reporting players

| Command | Description |
| --- | --- |
| `/report <player> <reason>` | Sent to staff + Discord staff channel |
| `/helpop <text>` | Ask staff for help |

Staff handle these via `STAFF.md` workflow.

## Community spaces

- `/warp market` (100, 70, 100) - community shop district. Plot rentals: $500/week.
- `/warp events` (200, 80, 200) - event arena for tournaments + seasonal events.
- Discord: `discord.gg/example` - bridged via DiscordSRV.
- Server status channel: auto-updates name to "online-12-of-100".

## Anti-toxicity

- AdvancedBan has built-in chat-filter wordlist. Edit
  `plugins/AdvancedBan/messages.yml -> Filter`.
- Anti-caps + anti-spam in EssentialsX antibuild section.
- `/ignore <player>` lets users self-mute toxic chatters.

## Recommended community rituals

- Weekly event (Saturday) - PvP or build contest.
- Monthly clan tournament with bracket via clan war system.
- Daily login bonus (Daily Crate key).
- Quarterly season reset of Battle Pass + leaderboards.
