vim.filetype.add({
	extension = {
		doxygen = "c",
	},

	pattern = {
		[".*%.c%.doxygen"] = "c",
		[".*%.cpp%.doxygen"] = "cpp",
	},
})
