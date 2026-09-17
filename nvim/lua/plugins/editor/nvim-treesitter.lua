return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},

	config = function()
		local install = require("nvim-treesitter.install")

		install.compilers = { "cl" }
		install.prefer_git = false

		vim.api.nvim_create_autocmd("Filetype", {
			callback = function(ev)
				pcall(vim.treesitter.start, ev.buf)
			end,
		})

		require("nvim-treesitter").setup({
			ensure_installed = {
				"c_sharp",
				"c",
				"cpp",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"javascript",
				"typescript",
				"python",
				"html",
				"css",
				"json",
				"bash",
			},

			sync_install = false,

			highlight = {
				enable = true,
			},

			indent = {
				enabled = true,
			},

			require("nvim-ts-autotag").setup(),
		})
	end,
}
