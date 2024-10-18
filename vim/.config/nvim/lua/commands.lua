local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local keymap = vim.api.nvim_set_keymap

-- Remember folds
augroup("remember_folds", { clear = true })
autocmd("BufWinLeave", {
	group = "remember_folds",
	pattern = "*{.wiki,.md}",
	command = "mkview",
})

-- Auto change directory
autocmd("BufEnter", {
	pattern = "*",
	command = "silent! lcd %:p:h",
})

-- Language-specific settings
autocmd("FileType", {
	pattern = "javascript,html",
	command = "setlocal shiftwidth=2 softtabstop=2 expandtab",
})



augroup("code_blocks", { clear = true })

autocmd("FileType", {
	pattern = "python",
	callback = function()
		keymap("v", "<leader>b", "<C-o>##<C-o>", {})
		keymap("n", "<leader>nb", "i##<C-o>", {})
	end,
})

autocmd("FileType", {
	pattern = "julia",
	callback = function()
		keymap("v", "<leader>b", "<C-o>##<C-o>", {})
		keymap("n", "<leader>nb", "i##<C-o>", {})
	end,
})

autocmd("FileType", {
	pattern = "cpp",
	callback = function()
		keymap("v", "<leader>b", "<C-o>/*---<C-o>", {})
		keymap("n", "<leader>nb", "i/*---<C-o>", {})
	end,
})

autocmd("FileType", {
	pattern = "javascript",
	callback = function()
		keymap("v", "<leader>b", "<C-o>//---<C-o>", {})
		keymap("n", "<leader>nb", "i//---<C-o>", {})
	end,
})

autocmd("BufEnter", {
	pattern = "*.{js,jsx,ts,tsx}",
	command = "syntax sync fromstart",
})

autocmd("BufLeave", {
	pattern = "*.{js,jsx,ts,tsx}",
	command = "syntax sync clear",
})

autocmd("BufEnter", {
	pattern = "*.{js,jsx,ts,tsx}",
	command = "setlocal foldmarker=≡-,──────",
})

autocmd("BufEnter", {
	pattern = "*",
	command = "silent! lcd %:p:h",
})
