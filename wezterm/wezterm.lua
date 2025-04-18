local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Color Scheme
config.color_scheme = 'Catppuccin Mocha'

-- Tab Bar Appearance
config.hide_tab_bar_if_only_one_tab = true

-- Keymaps
config.leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  {
    key = '|',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '-',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  { key = 'h',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'j',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection 'Down' },
  { key = 'k',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'l',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection 'Right' },
}

return config
