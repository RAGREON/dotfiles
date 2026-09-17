-- Oil
vim.keymap.set("n", "<leader>o", "<cmd>Oil<cr>", { desc = "Opens oil.nvim" })

-- Lsp Keybinds
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = "Show hover" })
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", { desc = "Go to definition" })
vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "Open code action" })
vim.keymap.set("x", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "Open code action" })

-- Formatter keybinds
vim.keymap.set({ "n", "v" }, "<leader>d", function()
	require("conform").format({
		async = true,
		lsp_fallback = true,
	})
end, { desc = "Format buffer asynchronously" })
vim.keymap.set("x", "<leader>d", "<cmd>lua vim.lsp.buf.format()<cr>", { desc = "Format Code" })

-- Reload Config
vim.keymap.set("n", "<leader>r", function()
	vim.cmd("source " .. vim.env.MYVIMRC)

	for name, _ in pairs(package.loaded) do
		if name:match("^config%.") then
			package.loaded[name] = nil
		end
	end

	vim.cmd("source " .. vim.env.MYVIMRC)
	vim.notify("Config reloaded")
end, { desc = "Reload Config" })
