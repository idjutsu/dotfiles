return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	-- config = function(_, opts)
	-- 	require("neo-tree").setup(opts)
	--
	-- 	-- UIが完全に立ち上がったら自動でNeo-treeを開く
	-- 	vim.api.nvim_create_autocmd("VimEnter", {
	-- 		callback = function()
	-- 			if vim.fn.argc() == 0 then -- 引数なし（=ファイル指定なし）のときだけ開く
	-- 				vim.cmd("Neotree show")
	-- 			end
	-- 		end,
	-- 	})
	-- end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	keys = {
		{
			"<leader>e",
			"<cmd>Neotree toggle<CR>",
			desc = "Toggle Neo-tree",
		},
	},
	lazy = false, -- neo-tree will lazily load itself
	---@module "neo-tree"
	---@type neotree.Config?
	opts = {
		-- fill any relevant options here
		filesystem = {
			filtered_items = {
				visible = true, -- フィルタされたアイテムも表示する
				hide_dotfiles = false, -- ドットファイルを隠さない
				hide_gitignored = false, -- gitignoreされたファイルも表示
				never_show = { ".DS_Store", ".git" }, -- これらだけを完全に非表示
			},
		},
		window = {
			mappings = {
				["l"] = "open", -- ファイル・フォルダを開く
				["h"] = "close_node", -- フォルダを閉じる
				["<space>"] = "none", -- （オプション）space割当を無効にしておくと誤爆防止に便利
			},
		},
	},
}
