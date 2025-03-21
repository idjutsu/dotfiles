return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
		--event = "LazyFile",
	},
	--event = { "LazyFile", "VeryLazy" },
	main = "nvim-treesitter.configs",
	opts = {
		--autotag = { enable = true },
		ensure_installed = {
			"bash",
			"html",
			"java",
			"javascript",
			"jsdoc",
			"json",
			"jsonc",
			"lua",
			"luadoc",
			"luap",
			"markdown",
			"markdown_inline",
			"php",
			"python",
			"query",
			"regex",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
			"yaml",
		},
		highlight = { enable = true },
		indent = { enable = true },
	},
}