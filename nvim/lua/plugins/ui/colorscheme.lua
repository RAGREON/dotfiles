return {
	{
		"catppuccin/nvim", lazy = true
	},
	{
		"ellisonleao/gruvbox.nvim",lazy = true
	},
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			-- Set active scheme here
			vim.cmd.colorscheme("tokyonight-night")
		end,
	},
}
