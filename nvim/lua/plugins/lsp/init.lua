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
	},

	config = function(_, opts)
		vim.lsp.config("*", {
			capabilities = vim.lsp.protocol.make_client_capabilities(),
		})

		require("mason-lspconfig").setup(opts)

		local group = vim.api.nvim_create_augroup("user-lsp-attach", {
			clear = true,
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = group,

			callback = function(event)
				local opts = {
					buffer = event.buf,
				}

				vim.keymap.set(
					"n",
					"K",
					function()
						vim.lsp.buf.hover()
					end,
					vim.tbl_extend("force", opts, {
						desc = "Hover",
					})
				)

				vim.keymap.set(
					"n",
					"gd",
					function()
						vim.lsp.buf.definition()
					end,
					vim.tbl_extend("force", opts, {
						desc = "Definition",
					})
				)

				vim.keymap.set(
					"n",
					"gD",
					function()
						vim.lsp.buf.declaration()
					end,
					vim.tbl_extend("force", opts, {
						desc = "Declaration",
					})
				)

				vim.keymap.set(
					"n",
					"gr",
					function()
						vim.lsp.buf.references()
					end,
					vim.tbl_extend("force", opts, {
						desc = "References",
					})
				)

				vim.keymap.set(
					"n",
					"gI",
					function()
						vim.lsp.buf.implementation()
					end,
					vim.tbl_extend("force", opts, {
						desc = "Implementation",
					})
				)

				vim.keymap.set(
					"n",
					"gK",
					function()
						vim.lsp.buf.signature_help()
					end,
					vim.tbl_extend("force", opts, {
						desc = "Signature help",
					})
				)

				vim.keymap.set(
					"n",
					"<leader>ca",
					function()
						vim.lsp.buf.code_action()
					end,
					vim.tbl_extend("force", opts, {
						desc = "Code action",
					})
				)

				vim.keymap.set(
					"n",
					"gl",
					function()
						vim.diagnostic.open_float()
					end,
					vim.tbl_extend("force", opts, {
						desc = "Line diagnostics",
					})
				)

				vim.keymap.set(
					"n",
					"[d",
					function()
						vim.diagnostic.goto_prev()
					end,
					vim.tbl_extend("force", opts, {
						desc = "Previous diagnostic",
					})
				)

				vim.keymap.set(
					"n",
					"]d",
					function()
						vim.diagnostic.goto_next()
					end,
					vim.tbl_extend("force", opts, {
						desc = "Next diagnostic",
					})
				)
			end,
		})
	end,
}
