vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- 2. Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})

	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

-- 3. Configure lazy.nvim
require("lazy").setup({
	spec = {
		-- Root plugins folder (lua/plugins/*.lua)
		{ import = "plugins" },
		-- Subdirectories
		{ import = "plugins.lsp" },
		{ import = "plugins.editor" },
		{ import = "plugins.ui" },
	},

	checker = {
		enabled = true,
		notify = false, -- Don't show popups every time updates are found
	},

	rocks = {
		enabled = false,
	},
})
