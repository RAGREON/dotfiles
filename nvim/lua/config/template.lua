vim.api.nvim_create_autocmd("BufNewFile", {
	pattern = "*.cs",
	callback = function()
		local file_dir = vim.fn.expand("%:p:h")
		local file_name = vim.fn.expand("%:t:r")

		-- 1. Search upward for the nearest .csproj file
		local csproj_files = vim.fs.find(function(name)
			return name:match("%.csproj$")
		end, { path = file_dir, upward = true, limit = 1 })

		local namespace = ""

		if #csproj_files > 0 then
			local csproj_path = csproj_files[1]
			local csproj_dir = vim.fs.dirname(csproj_path)

			-- Determine the base RootNamespace
			local base_namespace = vim.fn.fnamemodify(csproj_path, ":t:r")

			-- Parse .csproj to check for a customized <RootNamespace>
			local f = io.open(csproj_path, "r")
			if f then
				local content = f:read("*all")
				f:close()
				local root_ns_match = content:match("<RootNamespace>([^<]+)</RootNamespace>")
				if root_ns_match then
					base_namespace = vim.trim(root_ns_match)
				end
			end

			-- Calculate subdirectories relative to the .csproj location
			if file_dir == csproj_dir then
				namespace = base_namespace
			else
				local sub_dir = file_dir:sub(#csproj_dir + 2)
				local suffix = sub_dir:gsub("[/\\]", ".")
				namespace = base_namespace .. "." .. suffix
			end
		else
			-- Fallback to CWD if no .csproj is found
			local cwd = vim.fn.getcwd()
			local relative_path = file_dir:sub(#cwd + 2)
			namespace = relative_path:gsub("[/\\]", ".")
			if namespace == "" then
				namespace = vim.fn.fnamemodify(cwd, ":t")
			end
		end

		-- Clean up invalid characters
		namespace = namespace:gsub("[%s%-]", "_")

		-- 2. Determine type (Interface, Enum, or Class) based on naming conventions
		local type_keyword = "class"

		-- Matches naming like "IMyService" (Starts with uppercase I followed by an uppercase letter)
		if file_name:match("^I%u") then
			type_keyword = "interface"
		-- Matches naming like "UserStatusEnum" or "RoleEnum"
		elseif file_name:match("Enum$") then
			type_keyword = "enum"
		end

		-- 3. Construct the boilerplate
		local lines = {
			"namespace " .. namespace .. ";",
			"",
			"public " .. type_keyword .. " " .. file_name,
			"{",
			"    ",
			"}",
		}

		-- 4. Inject boilerplate and place cursor inside the brackets
		vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
		vim.api.nvim_win_set_cursor(0, { 5, 4 })
	end,
})
