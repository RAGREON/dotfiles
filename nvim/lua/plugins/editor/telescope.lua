return {
	"nvim-telescope/telescope.nvim",
	version = "*",

	dependencies = {
		"nvim-lua/plenary.nvim",

		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	keys = {
    { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find Files" },
    { "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Live Grep" },
    { "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Find Buffers" },
    { "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "Help Tags" },
  },

	config = function()
		local telescope = require("telescope")

		telescope.setup({
			defaults = {
				require("telescope.themes").get_ivy(),
        file_ignore_patterns = {
          "node_modules",
          "^.git/",
        }
			},
		})

		-- telescope.load_extension('fzf')
	end,
}
