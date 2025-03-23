vim.g.mapleader = " "

--

local function osc52_copy(text)
	local osc52 = "\x1b]52;c;" .. vim.fn.system("base64", text):gsub("\n", "") .. "\x07"
	io.write(osc52)
	io.flush()
end
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		local op = vim.v.event.operator
		local reg = vim.v.event.regname

		-- ""（デフォルトレジスタ）の操作だけ対象にする（他レジスタは無視）
		if reg == "" and (op == "y" or op == "d" or op == "c") then
			local text = vim.fn.getreg('"')
			if text and text ~= "" then
				osc52_copy(text)
			end
		end
	end,
})

--
