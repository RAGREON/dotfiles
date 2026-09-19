local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- Rendering / Graphics config
config.front_end = 'OpenGL'
config.max_fps = 144
config.animation_fps = 60
config.prefer_egl = false

config.initial_cols = 100
config.initial_rows = 28

config.font = wezterm.font("0xProto Nerd Font Mono")
config.font_size = 16
config.color_scheme = "tokyonight_night"
config.colors = {
	cursor_bg = "#7aa2f7",
	cursor_border = "#7aa2f7",
}

config.enable_tab_bar = false
config.window_decorations = "TITLE | RESIZE"

-- Keybinds
local keybinds = require("keybinds")
config.leader = keybinds.leader
config.keys = keybinds.keys

return config
