return {
	"saghen/blink.cmp",

	dependencies = {
		"saghen/blink.lib",
		"rafamadriz/friendly-snippets",
	},

	opts = {
		keymap = {
			preset = "default",
		},

		completion = {
			menu = {
				auto_show = true,
			},

			documentation = {
				auto_show = false,
			},
		},

		sources = {
			default = {
				"lsp",
				"path",
				"snippets",
				"buffer",
			},
		},

		fuzzy = {
			implementation = "rust",
		},
	},
}
