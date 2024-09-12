
--" Copilot
--let g:copilot_no_tab_map = v:true
--let g:copilot_assume_mapped = v:true
--imap <silent><script><expr> <C-Space> copilot#Accept("\<CR>")
--let g:copilot_filetypes = {
			--\ 'yaml': v:true,
			--\ }

local vim = vim

vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_filetypes = {
	yaml = true,
}

vim.api.nvim_set_keymap("i", "<C-Space>", "copilot#Accept('<CR>')", { silent = true, expr = true })

