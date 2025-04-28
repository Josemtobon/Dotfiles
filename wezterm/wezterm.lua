local wezterm = require("wezterm")
local config = wezterm.config_builder()
local action = wezterm.action

-- Color Scheme
config.color_scheme = "Tokyo Night"

-- Font Settings
config.font = wezterm.font("FiraCode Nerd Font")

-- Tab Bar Appearance
config.hide_tab_bar_if_only_one_tab = true

local function is_nvim(pane)
	local process_name = pane:get_foreground_process_name()
	return process_name and process_name:find("n?vim") ~= nil
end

local function directional_keybinding(key, direction, nvim_command)
	return {
		key = key,
		mods = "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_nvim(pane) then
				win:perform_action(action.SendKey({ key = key, mods = "CTRL" }), pane)
			else
				win:perform_action(action.ActivatePaneDirection(direction), pane)
			end
		end),
	}
end

-- Window Settings
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Keymaps
config.leader = { key = " ", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{
		key = "|",
		mods = "LEADER",
		action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},

	{
		key = "-",
		mods = "LEADER",
		action = action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	{
		key = "t",
		mods = "LEADER",
		action = action.SpawnTab("CurrentPaneDomain"),
	},

	directional_keybinding("h", "Left"),
	directional_keybinding("j", "Down"),
	directional_keybinding("k", "Up"),
	directional_keybinding("l", "Right"),

	{
		key = "h",
		mods = "CTRL|ALT",
		action = action.AdjustPaneSize({ "Left", 1 }),
	},

	{
		key = "j",
		mods = "CTRL|ALT",
		action = action.AdjustPaneSize({ "Down", 1 }),
	},
	{
		key = "k",
		mods = "CTRL|ALT",
		action = action.AdjustPaneSize({ "Up", 1 }),
	},
	{
		key = "l",
		mods = "CTRL|ALT",
		action = action.AdjustPaneSize({ "Right", 1 }),
	},
}

for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = action.ActivateTab(i - 1),
	})
end

return config
