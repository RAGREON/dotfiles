return {
	"stevearc/oil.nvim",

	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local oil = require("oil")

		oil.setup({
			columns = {
				"icon",
				"size",
			},

			keymaps = {
				["<C-<"] = { "actions.parent", mode = "n" },
				["<C->"] = { "actions.open_cwd", mode = "n" },
				["g<"] = { "actions.parent", mode = "n" },
			},

			view_options = {
				show_hidden = true,
			},
		})

		---------------------------------------------------------------------------
		-- C# file template
		---------------------------------------------------------------------------

		local function create_cs_template()
			local file_dir = vim.fn.expand("%:p:h")
			local file_name = vim.fn.expand("%:t:r")

			-------------------------------------------------------------------------
			-- Find nearest .csproj
			-------------------------------------------------------------------------

			local csproj_files = vim.fs.find(function(name)
				return name:match("%.csproj$")
			end, {
				path = file_dir,
				upward = true,
				limit = 1,
			})

			local namespace = ""

			if #csproj_files > 0 then
				local csproj_path = csproj_files[1]
				local csproj_dir = vim.fs.dirname(csproj_path)

				-- Default namespace = project name
				local base_namespace = vim.fn.fnamemodify(csproj_path, ":t:r")

				-----------------------------------------------------------------------
				-- Check for custom RootNamespace
				-----------------------------------------------------------------------

				local f = io.open(csproj_path, "r")

				if f then
					local content = f:read("*all")
					f:close()

					local root_namespace = content:match("<RootNamespace>([^<]+)</RootNamespace>")

					if root_namespace then
						base_namespace = vim.trim(root_namespace)
					end
				end

				-----------------------------------------------------------------------
				-- Add directory to namespace
				-----------------------------------------------------------------------

				if file_dir == csproj_dir then
					namespace = base_namespace
				else
					local sub_dir = file_dir:sub(#csproj_dir + 2)
					local suffix = sub_dir:gsub("[/\\]", ".")

					namespace = base_namespace .. "." .. suffix
				end
			else
				-----------------------------------------------------------------------
				-- Fallback if no .csproj exists
				-----------------------------------------------------------------------

				local cwd = vim.fn.getcwd()
				local relative_path = file_dir:sub(#cwd + 2)

				namespace = relative_path:gsub("[/\\]", ".")

				if namespace == "" then
					namespace = vim.fn.fnamemodify(cwd, ":t")
				end
			end

			-------------------------------------------------------------------------
			-- Clean namespace
			-------------------------------------------------------------------------

			namespace = namespace:gsub("[%s%-]", "_")

			-------------------------------------------------------------------------
			-- Detect type from filename
			-------------------------------------------------------------------------

			local type_keyword = "class"

			-- IUserService.cs -> interface
			if file_name:match("^I%u") then
				type_keyword = "interface"

			-- UserStatusEnum.cs -> enum
			elseif file_name:match("Enum$") then
				type_keyword = "enum"
			end

			-------------------------------------------------------------------------
			-- Template
			-------------------------------------------------------------------------

			local lines = {
				"namespace " .. namespace .. ";",
				"",
				"public " .. type_keyword .. " " .. file_name,
				"{",
				"    ",
				"}",
			}

			vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

			-- Put cursor inside braces
			vim.api.nvim_win_set_cursor(0, { 5, 4 })
		end

		---------------------------------------------------------------------------
		-- Apply template when Oil-created empty .cs file is opened
		---------------------------------------------------------------------------

		vim.api.nvim_create_autocmd("BufReadPost", {
			pattern = "*.cs",

			callback = function()
				local file = vim.fn.expand("%:p")

				-- Don't touch existing files
				if vim.fn.getfsize(file) ~= 0 then
					return
				end

				-- Prevent running more than once on the same buffer
				if vim.b.cs_template_applied then
					return
				end

				vim.b.cs_template_applied = true

				create_cs_template()
			end,
		})
	end,
}
