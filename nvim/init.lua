require("config.lazy")
require("config.terminal")
require("config.keybinds")
require("ibl").setup()

local disabled_plugins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit",
}

for _, plugin in ipairs(disabled_plugins) do
  vim.g["loaded_" .. plugin] = 1
end

vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.signcolumn = "yes:1"

vim.cmd("filetype plugin indent on")

vim.filetype.add({
  extension = {
    doxygen = "c",
  },
  pattern = {
    [".*%.c%.doxygen"] = "c",
    [".*%.cpp%.doxygen"] = "cpp",
  },
})
