local act = require("wezterm").action

local leader = { key = "Space", mods = "CTRL" }

local keys = {
	-- Panes
	{
		key = ";",
		mods = "LEADER",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},

	{
		key = "s",
		mods = "LEADER",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	{
		key = "d",
		mods = "LEADER",
		action = act.CloseCurrentPane({ confirm = true }),
	},

	{
		key = "z",
		mods = "LEADER",
		action = act.TogglePaneZoomState,
	},

	{
		key = "h",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Left"),
	},

	{
		key = "l",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Right"),
	},

	{
		key = "k",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Up"),
	},

	{
		key = "j",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Down"),
	},

	-- Tabs
	{
		key = "t",
		mods = "LEADER",
		action = act.SpawnTab("CurrentPaneDomain"),
	},

	{
		key = "n",
		mods = "LEADER",
		action = act.ActivateTabRelative(1),
	},
	{
		key = "p",
		mods = "LEADER",
		action = act.ActivateTabRelative(-1),
	},
}

return {
  leader,
  keys
}
