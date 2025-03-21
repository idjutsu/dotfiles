return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		local mason_null_ls = require("mason-null-ls")

		mason_null_ls.setup({
			ensure_installed = {
				"biome",
				"eslint-lsp",
				"prettier",
				"stylua",
			},
			handlers = {
				prettier = function()
					null_ls.register(null_ls.builtins.formatting.prettier.with({
						only_local = "node_modules/.bin",
					}))
				end,
			},
		})
		null_ls.setup({})
	end,
	dependencies = { "jay-babu/mason-null-ls.nvim" },
}