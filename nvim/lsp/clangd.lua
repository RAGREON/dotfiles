---@type vim.lsp.Config
return {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=iwyu",
		"--completion-style=detailed",
		"--function-arg-placeholders",
		"--fallback-style=llvm",
		"--query-driver=C:\\Users\\orex\\scoop\\apps\\llvm\\current\\bin\\clang.exe",
	},

	filetypes = {
		"c",
		"cpp",
		"objc",
		"objcpp",
	},

	settings = {
		clangd = {
			fallbackFlags = {
				"-std=c++20",
			},
		},
	},
}
