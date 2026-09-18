---@type vim.lsp.Config
return {
	settings = {
		Lua = {
			diagnostics = {
				globals = {
					"vim",
				},
			},

			workspace = {
				checkThirdParty = false,
			},

			completion = {
				callSnippet = "Replace",
			},
		},
	},
}
