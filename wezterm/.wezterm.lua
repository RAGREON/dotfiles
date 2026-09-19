local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- Rendering Config
config.front_end = 'OpenGL'
config.max_fps = 145
config.prefer_egl = false

config.initial_cols = 120
config.initial_rows = 30

config.font = wezterm.font("0xProto Nerd Font Mono")
config.font_size = 16
config.color_scheme = "tokyonight_night"
config.colors = {
	cursor_bg = "#7aa2f7",
	cursor_border = "#7aa2f7",
}

config.enable_tab_bar = false
config.window_decorations = "TITLE | RESIZE"

config.leader = { key = "Space", mods = "CTRL" }

config.keys = {
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
    action = act.ActivatePaneDirection 'Left',
  },

  {
    key = "l",
    mods = "LEADER",
    action = act.ActivatePaneDirection 'Right',
  },

  {
    key = "k",
    mods = "LEADER",
    action = act.ActivatePaneDirection 'Up',
  },

  {
    key = "j",
    mods = "LEADER",
    action = act.ActivatePaneDirection 'Down',
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

return config
