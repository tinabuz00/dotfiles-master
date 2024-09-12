local ns_id = vim.api.nvim_create_namespace('virtual_replacements')

local current_line = 0

local function findMatchesInLine(line, pattern)
    return coroutine.wrap(function()
        local start_pos = 1
		if not line then
			return
		end
        while true do
            local match_start, match_end = string.find(line, pattern, start_pos, true)
            if not match_start then return end  -- No more matches
            coroutine.yield(match_start, match_end)
            start_pos = match_end + 1  -- Prepare for the next match
        end
    end)
end

local function applyVirtualText(buf, pattern_replacements)
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local cursor_line = cursor_pos[1]

	if cursor_line == current_line then
		return
	end
	current_line = cursor_line

	for line_num = vim.fn.line('w0'), vim.fn.line('w$') do
        vim.api.nvim_buf_clear_namespace(buf, ns_id, line_num, line_num + 1)
        if line_num + 1 ~= cursor_line then
            local line = vim.api.nvim_buf_get_lines(buf, line_num, line_num + 1, false)[1]
            for _, pr in ipairs(pattern_replacements) do
				local pattern, replacement = pr[1], pr[2]
				local higroup = 'DiagnosticLineNrOk'
				if pr[3] then
					higroup = pr[3]
				end
                for start_idx, end_idx in findMatchesInLine(line, pattern) do
                    vim.api.nvim_buf_set_extmark(buf, ns_id, line_num, start_idx-1,{ 
						end_col = end_idx,
					conceal = '' })
                    vim.api.nvim_buf_set_extmark(buf, ns_id, line_num, start_idx, {
						virt_text = {{replacement,higroup }},
                        virt_text_pos = 'inline',
                    })

                end
            end
        end
    end
end

pad_ns_id = vim.api.nvim_create_namespace('virtual_padding')


local function setupAutoCommands(pattern_replacements)
    local buf = vim.api.nvim_get_current_buf()

    applyVirtualText(buf, pattern_replacements)

    vim.api.nvim_create_autocmd({'TextChanged', 'TextChangedI', 'CursorMoved', 'CursorMovedI'}, {
        buffer = buf,
        callback = function()
            applyVirtualText(buf, pattern_replacements)
        end,
    })
end
--define some custom highlights

vim.cmd('highlight Careful guifg=#FC863E gui=bold ctermfg=red cterm=bold')

vim.cmd('highlight TODO0 guifg=#FC863E gui=bold ctermfg=red cterm=bold')
vim.cmd('highlight TODODONE guifg=#FC863E gui=bold ctermfg=red cterm=bold')

setupAutoCommands({
	--warnings:
	{'!!!:', '  󰁔', 'Careful'},
	--errors:
	{'XXX:', '  󰁔', 'DiagnosticError'},
	--done:
	{'DONE:', '  󰁔', 'DiagnosticLineNrOk'},
	--ideas:
	{'IDEA:', '  󰁔', 'DiagnosticWarn'},
	--notes:
	{'NOTE:', '  󰁔', 'DiagnosticInfo'},
	--questions:
	{'???:', '  󰁔', 'DiagnosticHint'},

	{'->', '➜', 'DevIconArch'},
	{'=>', '󰁔➜', 'DevIconArch'},
	--{'# ', '│ ', 'Comment'},


	{'|-', '  ├', 'Comment'},
	{'|_', '  └', 'Comment'},
	{'||-', '  │  ├', 'Comment'},
	{'||_', '  │  └', 'Comment'},

	{'- [ ]', '┊- 󰄱 '},
	{'* [ ]', ' * 󰄱 '},

	{'- [.]', '┊-  ', 'DevIconArch'},
	{'- [o]', '┊-  ', 'DevIconArch'},
	{'- [O]', '┊-  ', 'DevIconArch'},
	{'- [x]', '┊-  ','DevIconAi'},
	{'- [X]', '┊-  ','DevIconAi'},


	{'* [.]', ' *  ', 'DevIconArch'},
	{'* [o]', ' *  ', 'DevIconArch'},
	{'* [O]', ' *  ', 'DevIconArch'},
	{'* [x]', ' *  ','DevIconAi'},
	{'* [X]', ' *  ','DevIconAi'},

	-- basic math stuff:
	{'^2', '²', 'Normal'},
	{'^3', '³', 'Normal'},
	{'^4', '⁴', 'Normal'},
})
-- progression of checkboxes: [ ], [.], [o], [O], [X]
-- as unicode we can precede the checbox with a vertical loading bar character of several levels:
-- small: 󰄱 󰄲 󰄳 󰄴 󰄵 󰄶 󰄷 󰄸 󰄹 󰄺
-- medium: 󰄻 󰄼 󰄽 󰄾 󰄿 󰅀 󰅁 󰅂 󰅃 󰅄
-- large: 󰅅 󰅆 󰅇 󰅈 󰅉 󰅊 󰅋 󰅌 󰅍 󰅎
--

vim.api.nvim_set_hl(0, "VimwikiWebLink1", { link = "@text.uri" })
vim.api.nvim_set_hl(0, "VimwikiHeader1", { link = "WarningMsg" })
vim.api.nvim_set_hl(0, "VimwikiHeader2", { link = "DiagnosticWarn" })
vim.api.nvim_set_hl(0, "VimwikiHeader3", { link = "DevIconAi" })
vim.api.nvim_set_hl(0, "VimwikiItalic", { italic=true, blend=50, underdotted = true })


-- set tab to 2 spaces:
vim.bo.tabstop = 3
vim.bo.softtabstop = 3
vim.bo.shiftwidth = 3
--vim.bo.expandtab = false


-- create some shortcuts:
-- in viksual mode, pressing b makes the text bold (surrounds it with __ on both side)
vim.api.nvim_set_keymap('v', 'b', '<esc>`<i__<esc>`>a__<esc>', { noremap = true, silent = true })
-- cc to call VimwikiToggleListItem:
vim.api.nvim_set_keymap('n', 'cc', ':lua vim.cmd("VimwikiToggleListItem")<CR>', { noremap = true, silent = true })

