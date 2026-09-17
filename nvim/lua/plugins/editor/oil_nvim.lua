return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		columns = {
			"icon",
			"size",
		},
		win_options = {
			relativenumber = true,
      statuscolumn = "",
		},
		keymaps = {
			["<C-<"] = { "actions.parent", mode = "n" },
			["<C->"] = { "actions.open_cwd", mode = "n" },
			["g<"] = { "actions.cd", mode = "n" },
			["g>"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
		},
	},

	-- Optional dependencies
	dependencies = { { "nvim-mini/mini.icons", opts = {} } },

	lazy = false,
}
