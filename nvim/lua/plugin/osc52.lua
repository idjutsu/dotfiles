return {
	"ojroques/nvim-osc52",
	config = function()
		require("osc52").setup({
			max_length = 0, -- 無制限（ターミナルが許す限り）
			silent = false, -- trueにすると :messages に出なくなる
			trim = false, -- 末尾の空行トリミングしない
		})

		-- "y", "d", "c" 操作時、自動で OSC52 コピー（デフォルトレジスタのみ）
		vim.api.nvim_create_autocmd("TextYankPost", {
			callback = function()
				local op = vim.v.event.operator
				local reg = vim.v.event.regname
				if (op == "y" or op == "d" or op == "c") and reg == "" then
					require("osc52").copy_register('"')
				end
			end,
		})
	end,
}
