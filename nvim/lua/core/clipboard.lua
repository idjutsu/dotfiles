-- Base64 encode（OSC52用）
local function base64_encode(data)
	local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	return (
		(data:gsub(".", function(x)
			local r, bval = "", x:byte()
			for i = 8, 1, -1 do
				r = r .. (bval % 2 ^ i - bval % 2 ^ (i - 1) > 0 and "1" or "0")
			end
			return r
		end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
			if #x < 6 then
				return ""
			end
			local c = 0
			for i = 1, 6 do
				c = c + (x:sub(i, i) == "1" and 2 ^ (6 - i) or 0)
			end
			return b:sub(c + 1, c + 1)
		end) .. ({ "", "==", "=" })[#data % 3 + 1]
	)
end

-- OSC52 でコピー（4096文字以内推奨）
local function osc52_copy(text)
	local encoded = base64_encode(text)
	local osc52 = "\x1b]52;c;" .. encoded .. "\x07"
	io.write(osc52)
	io.flush()
end

-- ヤンク時に自動コピー
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		local op = vim.v.event.operator
		local reg = vim.v.event.regname
		if reg == "" and (op == "y" or op == "d" or op == "c") then
			local text = vim.fn.getreg('"')
			if text and text ~= "" then
				osc52_copy(text)
			end
		end
	end,
})
