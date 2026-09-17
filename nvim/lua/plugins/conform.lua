return {
	"stevearc/conform.nvim",
  event = { "BufReadPost", "BufNewFile" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			cs = { "csharpier" },
		},
	},
}
