return {
	"neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"saghen/blink.cmp",
		"saghen/blink.lib",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")

		-- Fix: Typo corrected (capabilities)
		local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()

		-- Fix: Initialize mason core first
		mason.setup()

		mason_lspconfig.setup({
			ensure_installed = { "lua_ls", "clangd" },

			handlers = {
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = lsp_capabilities,
					})
				end,
			},
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP actions",
			callback = function(event)
				local bufmap = function(mode, lhs, rhs)
					local opts = { buffer = event.buf }
					vim.keymap.set(mode, lhs, rhs, opts)
				end

				bufmap("n", "K", function()
					vim.lsp.buf.hover({ border = "rounded" })
				end)
				bufmap("n", "gd", function()
					vim.lsp.buf.signature_help({ border = "rounded" })
				end)

				bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
				bufmap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>")
				bufmap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
				bufmap("n", "gr", vim.lsp.buf.references)
				bufmap("n", "<leader>pd", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
				bufmap("n", "<leader>nd", "<cmd>lua vim.diagnostic.goto_next()<cr>")
			end,
		})

		vim.diagnostic.config({
			virtual_text = false,
			severity_sort = true,
			float = { border = "rounded", source = "always" },
		})
	end,
}
