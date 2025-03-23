-- TextYankPostイベントでヤンクされたテキストをMacクリップボードに送る

-- Macのpbcopyを使ってテキストをクリップボードに送信
local function pbcopy_copy(text)
	local handle = io.popen("pbcopy", "w")
	if handle then
		handle:write(text)
		handle:close()
	end
end

-- ヤンク操作のあとに自動でpbcopyに送信
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		local op = vim.v.event.operator -- 実行された操作（"y", "d", "c"など）
		local reg = vim.v.event.regname -- 使用されたレジスタ（""はデフォルト）

		-- デフォルトレジスタかつ "y", "d", "c" のときだけ処理する
		if reg == "" and (op == "y" or op == "d" or op == "c") then
			local text = vim.fn.getreg('"') -- ヤンク内容を取得
			if text and text ~= "" then
				pbcopy_copy(text) -- Macクリップボードへコピー
				print("[PB] コピー完了！") -- デバッグ出力（:messages で確認可）
			end
		end
	end,
})
