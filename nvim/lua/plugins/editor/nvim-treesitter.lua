return {
	"nvim-treesitter/nvim-treesitter",

	lazy = false,
	build = ":TSUpdate",

	config = function()
		require("nvim-treesitter").setup()

		require("nvim-treesitter").install({
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
		})

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(ev)
				pcall(vim.treesitter.start, ev.buf)

				vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
