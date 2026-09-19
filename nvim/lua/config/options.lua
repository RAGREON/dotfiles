local opt = vim.opt

opt.relativenumber = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true

opt.signcolumn = "yes:1"

vim.cmd("filetype plugin indent on")

-- Clear search highlight after confirming a search
vim.api.nvim_create_autocmd("CmdlineLeave", {
	pattern = { "/", "?" },
	callback = function()
		vim.schedule(function()
			vim.cmd("nohlsearch")
		end)
	end,
})

-- Toggle search highlighting
vim.keymap.set("n", "<leader>h", ":set hlsearch!<CR>", {
	silent = true,
	desc = "Toggle search highlight",
})
