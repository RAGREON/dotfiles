vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Disable built-in plugins replaced by external plugins.
local disabled_plugins = {
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
}

for _, plugin in ipairs(disabled_plugins) do
	vim.g["loaded_" .. plugin] = 1
end

-- Core configuration
require("config.options")
require("config.filetypes")

-- Plugin manager
require("config.lazy")

-- User configuration
require("config.keybinds")
require("config.terminal")
