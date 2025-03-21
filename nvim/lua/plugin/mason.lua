return {
	"williamboman/mason.nvim",
	config = function()
		local lspconfig = require("lspconfig")

		require("mason").setup({})
		require("mason-lspconfig").setup({
			ensure_installed = {
				"bashls",
				"cssls",
				"emmet_language_server",
				"html",
				"intelephense",
				"jdtls",
				"jsonls",
				"lua_ls",
				"markdown_oxide",
				"tailwindcss",
				"ts_ls",
			},
			handlers = {
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = require("cmp_nvim_lsp").default_capabilities(),
					})
				end,
				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						on_init = function(client)
							local path = client.workspace_folders[1].name
							if
								vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc")
							then
								return
							end
							client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
								runtime = {
									version = "LuaJIT",
								},
								workspace = {
									checkThirdParty = false,
									library = {
										vim.env.VIMRUNTIME,
									},
								},
							})
						end,
						settings = {
							Lua = {},
						},
					})
				end,
				["tailwindcss"] = function()
					lspconfig.tailwindcss.setup({
						settings = {
							tailwindCSS = {
								experimental = {
									classRegex = {
										{ "TailwindCss::createClassName\\(\\[([^;]*)\\]\\)", '"([^"]*)"' },
									},
								},
							},
						},
					})
				end,
			},
		})
	end,
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
	},
}