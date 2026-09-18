return {
	"mason-org/mason-lspconfig.nvim",

	event = { "BufReadPre", "BufNewFile" },

	opts = {
		ensure_installed = {
			"lua_ls",
			"clangd",
			"roslyn_ls",
			"neocmake",
		},

		automatic_enable = true,
	},

	dependencies = {
		{
			"mason-org/mason.nvim",
			opts = {},
		},

		"neovim/nvim-lspconfig",
		"saghen/blink.cmp",
	},

	config = function(_, opts)
		vim.lsp.config("*", {
			capabilities = require("blink.cmp").get_lsp_capabilities(),
		})

		require("mason-lspconfig").setup(opts)

		local group = vim.api.nvim_create_augroup("user-lsp-attach", {
			clear = true,
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = group,

			callback = function(event)
				local map = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, {
						buffer = event.buf,
						desc = desc,
					})
				end

				map("n", "K", vim.lsp.buf.hover, "Hover")
				map("n", "gd", vim.lsp.buf.definition, "Definition")
				map("n", "gD", vim.lsp.buf.declaration, "Declaration")
				map("n", "gr", vim.lsp.buf.references, "References")
				map("n", "gI", vim.lsp.buf.implementation, "Implementation")
				map("n", "gK", vim.lsp.buf.signature_help, "Signature help")
				map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
				map("n", "gl", vim.diagnostic.open_float, "Line diagnostics")
				map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
				map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
			end,
		})
	end,
}
