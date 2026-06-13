# DeluxeMenus Reference

Player-facing GUI menu system via **DeluxeMenus 1.14.1**.

## Menus included

| Menu | Open command | Description |
| --- | --- | --- |
| `main` | `/menu` or `/hub` | Central hub with 20+ buttons |
| `warps` | `/warps` or from main | Warp picker (spawn / pvp / bosses / info / store / market / events) |
| `profile` | `/profile` or main -> head | Player profile (balance, level, kills, clan, hearts, votes) |
| `shop` | `/shopmenu` | Category picker that opens server shop |
| `rtp` | `/rtpmenu` or `/wildmenu` | Wild-world teleport menu |

## Player commands

| Command | Action | Perm |
| --- | --- | --- |
| `/menu` | Open the main hub | `deluxemenus.menu.main` (default) |
| `/menu <name>` | Open a specific menu | `deluxemenus.menu.<name>` |
| `/profile`, `/warps`, `/shopmenu`, `/wildmenu` | Open those menus directly | default |
| `/dm list` | List loaded menus | admin |
| `/dm reload` | Reload menu configs | admin |

## Main hub layout

```
+---+---+---+---+---+---+---+---+---+
| . | . | . | . |HEAD| . | . | . | . |    Row 0
+---+---+---+---+---+---+---+---+---+
| . | . | . | . | . | . | . | . | . |    Row 1
+---+---+---+---+---+---+---+---+---+
| . |SHO|AH |PSH|CRA|QUE|SKI|WAR| . |    Row 2  (shop/ah/pshops/crates/quests/skills/warps)
+---+---+---+---+---+---+---+---+---+
| . |WLD|CLN|PVP|BOS|COS|VOT|BP | . |    Row 3  (wild/clans/pvp/bosses/cosmetics/vote/bp)
+---+---+---+---+---+---+---+---+---+
| . |RUL|DSC|RNK|HLP|SPN|DLY|SET| . |    Row 4
+---+---+---+---+---+---+---+---+---+
| . | . | . | . | . | . | . | . | . |    Row 5 (filler)
+---+---+---+---+---+---+---+---+---+
```

Player head at center top shows balance, rank, level, K/D — click for full
profile.

## Install

1. **DeluxeMenus jar** is already in `plugins/`.
2. Restart the server so DeluxeMenus generates default files.
3. Copy templates:

```
copy setup\configs\deluxemenus\config.yml                     plugins\DeluxeMenus\config.yml
copy setup\configs\deluxemenus\gui_menus\main.yml             plugins\DeluxeMenus\gui_menus\main.yml
copy setup\configs\deluxemenus\gui_menus\warps.yml            plugins\DeluxeMenus\gui_menus\warps.yml
copy setup\configs\deluxemenus\gui_menus\profile.yml          plugins\DeluxeMenus\gui_menus\profile.yml
copy setup\configs\deluxemenus\gui_menus\shop.yml             plugins\DeluxeMenus\gui_menus\shop.yml
copy setup\configs\deluxemenus\gui_menus\rtp.yml              plugins\DeluxeMenus\gui_menus\rtp.yml
```

4. Reload: `/dm reload`.

## Action codes (DeluxeMenus syntax)

| Action | Example | Meaning |
| --- | --- | --- |
| `[player]` | `[player] spawn` | Run as the clicking player |
| `[console]` | `[console] eco give %player_name% 100` | Run as console |
| `[openguimenu]` | `[openguimenu] warps` | Open another DM menu |
| `[close]` | `[close]` | Close the current menu |
| `[sound]` | `[sound] UI_BUTTON_CLICK` | Play a sound |
| `[message]` | `[message] &aYou clicked!` | Send a chat message |
| `[broadcast]` | `[broadcast] &cAttention!` | Broadcast to all |
| `[teleport]` | `[teleport] 0 100 0` | Direct TP |
| `[playerchat]` | `[playerchat] hi` | Make player say something |

## Conditional clicks (rank-locked items)

Example: only allow VIP+ to click a button.

```yaml
view_requirement:
  requirements:
    is_vip:
      type: 'has permission'
      permission: 'group.vip'
      minimum: 1
```

Or use `click_requirement` to gate the action itself.

## Placeholder reference

All PlaceholderAPI placeholders work. Common ones used in our menus:

- `%player_name%`, `%player_displayname%`
- `%vault_eco_balance%`, `%vault_eco_baltop_position%`
- `%luckperms_prefix%`, `%luckperms_suffix%`, `%luckperms_primary_group_name%`
- `%auraskills_overall_level%`, `%auraskills_<skill>_level%`
- `%statistic_player_kills%`, `%statistic_deaths%`, `%statistic_mob_kills%`
- `%simpleclans_clan_tag%`, `%simpleclans_clan_kdr%`
- `%lifestealz_hearts%`
- `%essentials_uptime%`, `%essentials_home_count%`
- `%votingplugin_total_votes%`, `%votingplugin_total_votes_currentmonth%`

If a placeholder shows raw (e.g. `%xyz_thing%`), install its PAPI expansion:

```
/papi ecloud download <name>
/papi reload
```

## Add your own menu

1. Make `plugins/DeluxeMenus/gui_menus/myown.yml`:

   ```yaml
   menu_title: '&6&lMy Menu'
   open_command: mymenu
   size: 27
   items:
     fancy_button:
       material: DIAMOND
       slot: 13
       display_name: '&bClick me'
       left_click_commands:
         - '[player] balance'
         - '[message] &aYou clicked!'
   ```

2. Register in `config.yml`:

   ```yaml
   gui_menus:
     myown:
       file: myown.yml
   ```

3. `/dm reload`. Test `/mymenu`.

## Troubleshooting

| Symptom | Fix |
| --- | --- |
| `/menu` says "Unknown command" | DeluxeMenus not loaded. Check console for errors. |
| Placeholders show raw | Install PAPI expansion + `/papi reload`. |
| Click does nothing | Check player has perms for the inner command. |
| Menu doesn't reload | `/dm reload`. If YAML is broken, you'll see an error in console. |
| Items wrong material | Check material name in https://hub.spigotmc.org/javadocs/spigot/org/bukkit/Material.html |
