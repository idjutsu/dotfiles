return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		config = function()
			local telescope = require("telescope")

			-- Telescopeの基本設定
			telescope.setup({
				defaults = {
					file_ignore_patterns = { "%.git$", "%.git/", "%.DS_Store$", "node_modules", "vendor/" }, -- 除外したいフォルダ
				},
				extensions = {
					file_browser = {
						--cwd_to_path = true,
						file_ignore_patterns = { "%.git$", "%.git/", "%.DS_Store$", "vendor/" },
						hidden = true,
						hijack_netrw = true, -- netrwを無効化
						path = "%:p:h",
						previewer = false,
						select_buffer = true,
					},
					fzf = {
						case_mode = "smart_case", -- 大文字小文字を自動判別
						fuzzy = true, -- 曖昧検索を有効化
						override_generic_sorter = true, -- sorterをfzfに置き換え
						override_file_sorter = true, -- ファイル検索時のソートをfzfに
					},
				},
				pickers = {
					find_files = {
						hidden = true, -- 🔥 隠しファイルを表示する設定
						no_ignore = true,
					},
				},
			})

			-- 拡張機能のロード
			telescope.load_extension("file_browser")
			telescope.load_extension("fzf")

			-- Telescopeのキーマッピング
			local map = vim.api.nvim_set_keymap
			local opts = { noremap = true, silent = true }

			-- 基本機能
			map("n", "<leader>ff", ":Telescope find_files<CR>", opts) -- ファイル検索
			map("n", "<leader>fg", ":Telescope live_grep<CR>", opts) -- ファイル内検索
			map("n", "<leader>fb", ":Telescope buffers<CR>", opts) -- バッファ一覧
			map("n", "<leader>fh", ":Telescope help_tags<CR>", opts) -- ヘルプ検索
			map("n", "<leader>fo", ":Telescope oldfiles<CR>", opts) -- 最近開いたファイル
			map("n", "<leader>fm", ":Telescope marks<CR>", opts) -- マーク一覧
			map("n", "<leader>fk", ":Telescope keymaps<CR>", opts) -- キーマップ一覧
			map("n", "<leader>fr", ":Telescope resume<CR>", opts) -- 直前のTelescopeを再開

			-- ファイルブラウザ
			map("n", "<leader>fd", ":Telescope file_browser<CR>", opts) -- ファイルブラウザを開く
			map("n", "<leader>fn", ":Telescope file_browser path=%:p:h<CR>", opts) -- 現在のファイルのディレクトリを開く

			-- LSP関連
			map("n", "<leader>ls", ":Telescope lsp_document_symbols<CR>", opts) -- 現在のバッファのシンボル一覧
			map("n", "<leader>lw", ":Telescope lsp_workspace_symbols<CR>", opts) -- ワークスペース全体のシンボル検索
			map("n", "<leader>ld", ":Telescope diagnostics<CR>", opts) -- 診断情報一覧
			map("n", "<leader>lr", ":Telescope lsp_references<CR>", opts) -- カーソル下のシンボルの参照を検索
			map("n", "<leader>li", ":Telescope lsp_implementations<CR>", opts) -- 実装を検索

			-- Git 関連
			map("n", "<leader>gc", ":Telescope git_commits<CR>", opts) -- Git コミット履歴
			map("n", "<leader>gb", ":Telescope git_branches<CR>", opts) -- Git ブランチ一覧
			map("n", "<leader>gs", ":Telescope git_status<CR>", opts) -- Git の変更されたファイル一覧
			map("n", "<leader>gS", ":Telescope git_stash<CR>", opts) -- Git スタッシュ一覧
		end,
	},
}
