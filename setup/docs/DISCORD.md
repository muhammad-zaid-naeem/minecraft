# Discord Integration

Plugin: **DiscordSRV 1.30.5**. Two-way chat bridge, account linking, role
sync, staff logs, join/leave logs, and live status channel.

## Required Discord setup

1. Create an application at https://discord.com/developers/applications.
2. Add a Bot to the application. Copy the **Token** (you'll paste it into
   DiscordSRV config).
3. Enable "Message Content Intent" and "Server Members Intent" under the bot
   page.
4. Invite the bot to your server using the OAuth2 URL builder with scopes:
   `bot`, `applications.commands`, and permissions: Send Messages, Embed
   Links, Read Message History, Manage Channels, Manage Roles.
5. Create the following channels in your Discord:

| Discord channel | Purpose |
| --- | --- |
| `#in-game-chat` | Two-way chat bridge with in-game global chat |
| `#staff-chat` | Mirrors `/sc` staff chat |
| `#console` | Server console output (read-only for staff) |
| `#account-link` | Sends one-time link codes |
| `#join-leave` | Join + leave + first-time joins |
| `#staff-logs` | Bans, mutes, warns, reports |
| `#status` | Auto-renamed to "online-12-of-100" |

Copy each channel's ID (right-click -> Copy ID with developer mode on).

## DiscordSRV config snippets

`plugins/DiscordSRV/config.yml`:

```yaml
BotToken: "PASTE_YOUR_TOKEN_HERE"

Channels:
  global: "111111111111111111"
  staff: "222222222222222222"
  console: "333333333333333333"
  link: "444444444444444444"
  joinleave: "555555555555555555"
  stafflogs: "666666666666666666"

DiscordChatChannelMinecraftToDiscordFormat: "**%username%**: %message%"
DiscordChatChannelDiscordToMinecraftFormat: '&9[Discord] &f%username%&7: &f%message%'

NicknameSynchronizationEnabled: true
RequireLinkedAccountToChat: false
ChannelLockingViaChannelTopic: false

GroupRoleSynchronizationEnabled: true
GroupRoleSynchronizationGroupsAndRolesToSync:
  vip: "1100000000000000001"
  mvp: "1100000000000000002"
  elite: "1100000000000000003"
  mod: "1100000000000000004"
  admin: "1100000000000000005"
  owner: "1100000000000000006"
GroupRoleSynchronizationOneWay: false      # both directions; set true to push only from MC->Discord

JoinMessageEnabled: true
JoinMessageFormat: "**%username%** joined the server."
LeaveMessageFormat: "**%username%** left the server."
FirstJoinPrefix: "Welcome"

StatusChannelEnabled: true
StatusChannelFormat: "online-%online%-of-%max%"
StatusChannelUpdateInterval: 300                  # seconds

ConsoleChannelUsageWarningWebhook: true
```

Full default template ships with the plugin; use the template at
`setup/configs/discordsrv/config.yml` as a starting point.

## Account linking

Player in-game:

```
/discord link
```

Bot DMs them a 6-digit code; player pastes it in `#account-link`. On success:
- Discord nickname updated to MC name.
- Discord roles auto-applied based on LuckPerms group.
- Chat from Discord now shows their Discord avatar in chat embeds.

Unlink:

```
/discord unlink
```

## Two-way chat

- Anything sent in `#in-game-chat` mirrors to the game with format
  `&9[Discord] &f<name>&7: <msg>`.
- Anything in-game (excluding staff/operator commands) mirrors to Discord as
  `**name**: msg`.
- `@username` mentions get parsed both ways.
- Embedded images and links from Discord render as clickable text.

## Staff logs

Bans, kicks, mutes and warns from **AdvancedBan** go to `#staff-logs` via
the AdvancedBan webhook. Configure in `plugins/AdvancedBan/Layouts.yml`:

```yaml
DiscordWebhook:
  enabled: true
  url: "https://discord.com/api/webhooks/.../..."
  username: "Punishment Log"
  avatar: "https://cdn.../avatar.png"
```

Reports (`/report <player>`) also funnel to `#staff-logs`.

## Status channel

DiscordSRV updates the name of the configured status channel every 5 minutes
to reflect player count. Players see "online-12-of-100" in the sidebar
without joining.

## Console bridge

Console output is mirrored to `#console`. Commands typed in `#console` execute
as console on the server (requires the user have the bot-side permission
`discordsrv.console`).

WARNING: this is powerful - restrict the `#console` channel to staff only with
Discord channel permissions.

## Test

```
/discord                       # in-game; prints invite link
/discord link                  # links your account
/discord reload                # reload bot
```

In Discord:

- Type a message in `#in-game-chat` -> appears in-game.
- Send a `/help` in Discord -> bot responds.
- Watch `#status` channel name auto-update.

## Troubleshooting

| Symptom | Fix |
| --- | --- |
| Bot offline | Token wrong, or "Message Content Intent" disabled in dev portal. |
| Roles don't sync | Bot role must be HIGHER in Discord role hierarchy than the roles it manages. |
| `/discord link` fails | Bot lacks DM permission - the user must have DMs from server members enabled. |
| Console spam | Disable `DiscordConsoleChannelLevelFilter` for low-priority logs. |
| Group sync loops | Set `GroupRoleSynchronizationOneWay: true` (push from MC only). |
