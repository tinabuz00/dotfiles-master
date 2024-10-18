vim.cmd.aunmenu([[PopUp]])
--vim.cmd.aunmenu([[PopUpi]])
--vim.cmd.aunmenu([[PopUpc]])
--vim.cmd.aunmenu([[PopUpn]])
--vim.cmd.aunmenu([[PopUpv]])
--vim.cmd.aunmenu([[PopUpo]])
--vim.cmd.aunmenu([[Plugin]])
--vim.cmd.aunmenu([[Plugin]])

local default_menu_mode = "ni"

local menus = {
	Window = {
		priority = 10,
		["Show Document Symbols"] = { cmd = ":Telescope lsp_document_symbols<CR>", priority = 180 },
		["Show Code Actions"] = { cmd = ":Telescope lsp_code_actions<CR>", priority = 190 },
		["All Diagnostics"] = { cmd = ":TroubleToggle", shortcut = ",tt", priority = 7 },
		["Gitsigns"] = { cmd = ":Gitsigns toggle_signs", shortcut = "", priority = 12 },
		["Undo (Fuzzy)"] = { cmd = ":Telescope undo", shortcut = "", priority = 13 },
		["Undo (Tree)"] = { cmd = ":UndotreeToggle", priority = 15 },
	},

	PopUp = {
		priority = 1000,
		["-Sep1-"] = { cmd = ":", priority = 1, mode = "a" },
		["Show Information"] = { cmd = ":lua vim.lsp.buf.hover()<CR>", shortcut = "K", priority = 40 },
		["Show References"] = { cmd = ":Telescope lsp_references<CR>", priority = 50 },
		["Show Signature Help"] = { cmd = ":lua vim.lsp.buf.signature_help()<CR>", priority = 60 },
		["Show Line Diagnostic"] = { cmd = ":lua vim.diagnostic.open_float()<CR>", shortcut = ",e", priority = 70 },

		["-Sep2-"] = { cmd = ":", priority = 100 },

		["Jump to Definition"] = { cmd = ":lua vim.lsp.buf.definition()<CR>", shortcut = "gd", priority = 110 },
		["Jump to Declaration"] = { cmd = ":lua vim.lsp.buf.declaration()<CR>", shortcut = "gD", priority = 115 },
		["Jump to Implementation"] = { cmd = ":lua vim.lsp.buf.implementation()<CR>", shortcut = "gi", priority = 120 },
		["Jump to Next Diagnostic"] = { cmd = ":lua vim.diagnostic.goto_next()<CR>", shortcut = "[d", priority = 130 },
		["Jump to Prev Diagnostic"] = { cmd = ":lua vim.diagnostic.goto_prev()<CR>", shortcut = "]d", priority = 140 },

		["-Sep3-"] = { cmd = ":", priority = 200 },
		["Rename"] = { cmd = ":lua vim.lsp.buf.rename()<CR>", shortcut = ",r", priority = 210 },
		["Code action"] = { cmd = ":lua vim.lsp.buf.code_action()<CR>", priority = 220 },

		["-Comments-"] = { cmd = ":", priority = 300 },
		["Comment Line"] = { cmd = "<Plug>NERDCommenterComment", shortcut = ",cc", priority = 310, mode = "ni" },
		["Uncomment Line"] = { cmd = "<Plug>NERDCommenterUncomment", shortcut = ",cu", priority = 320, mode = "ni" },

		["-S4-"] = { cmd = ":", priority = 400 },
		["Find Files"] = { cmd = "<cmd>Telescope pathogen find_files<CR>", shortcut = "ff", priority = 410 },
		["Live Grep"] = { cmd = "<cmd>Telescope pathogen live_grep<CR>", shortcut = "fg", priority = 420 },
		["Undo History"] = { cmd = ":UndotreeToggle<CR>", priority = 430 },
		["File Browser"] = { cmd = ":Neotree toggle<CR>", shortcut = "<F2>", priority = 440 },

		-- some selection specific actions:
		["Comment Selection"] = { cmd = "<Plug>NERDCommenterComment", shortcut = ",cc", priority = 310, mode = "v" },
		["Uncomment Selection"] = { cmd = "<Plug>NERDCommenterUncomment", shortcut = ",cu", priority = 320, mode = "v" },
		["Format Selection"] = { cmd = "<Plug>(FormatSelection)", shortcut = ",fs", priority = 340, mode = "v" },
		["Replace Selection in File"] = {
			cmd = ":lua ReplaceSelection()<CR>",
			shortcut = "<C-r>",
			priority = 350,
			mode = "v",
		},

		["-S5-"] = { cmd = ":", priority = 500, mode = "a" },
	},
}

local menu_entry_length = 25

local function make_menu(path, table, priorities)
	for name, item in pairs(table) do
		if type(item) == "table" and item.cmd then
			-- This is a menu item
			if not name:match("^%-.*%-$") then
				-- pad the menu entry to a fixed length
				name = " · " .. name .. string.rep(" ", menu_entry_length - #name)
			end
			local menu_path = path .. (path ~= "" and "." or "") .. name
			local priority = item.priority and item.priority or ""
			local menu_priority = priorities and priorities .. "." .. priority or priority

			if item.shortcut ~= nil then
				menu_path = menu_path .. " ┆ " .. item.shortcut .. " "
			end

			local menu_item = menu_path:gsub("%s", "\\ ") -- Escape spaces

			local menumode = item.mode or default_menu_mode
			for i = 1, #menumode do
				local mode = menumode:sub(i, i)
				local menucmd = mode .. "menu"
				local amenu_str = string.format("%s %s %s %s", menucmd, menu_priority, menu_item, item.cmd)
				vim.cmd(amenu_str)
			end
		elseif type(item) == "table" then
			-- This is a submenu, recurse into it
			local priority = item.priority and item.priority or ""
			-- concat priorities with a dot, just like path
			local new_path = path .. (path ~= "" and "." or "") .. name
			local new_priorities = priorities and priorities .. "." .. priority or priority
			make_menu(new_path, item, new_priorities)
		end
	end
end

make_menu("", menus)

function StylishMenu()
	require("stylish").ui_menu(
		vim.fn.menu_get(""),
		{ kind = "menu", prompt = "Main Menu", experimental_mouse = true },
		function(res)
			vim.cmd(res)
		end
	)
end

vim.api.nvim_set_keymap("n", "<F1>", "<Cmd>lua StylishMenu()<CR>", { noremap = true, silent = true })

vim.cmd([[

" UltiSnips
let g:UltiSnipsNoMap = 1
let g:UltiSnipsExpandTrigger="<C-o>"
let g:UltiSnipsJumpForwardTrigger="<C-b>"
let g:UltiSnipsJumpBackwardTrigger="<C-x>"
let g:UltiSnipsEditSplit="horizontal"
let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"
" debug with vimspector
let g:vimspector_enable_mappings = 'HUMAN'


let g:jupyter_mapkeys = 0
nnoremap <buffer> <silent> <localleader>j :JupyterConnect<CR>
" Run current file
nnoremap <buffer> <silent> <localleader>r :JupyterRunFile<CR>
nnoremap <buffer> <silent> <localleader>i :PythonImportThisFile<CR>
" Change to directory of current file
nnoremap <buffer> <silent> <localleader>d :JupyterCd %:p:h<CR>
" Send a selection of lines
nnoremap <buffer> <silent> <localleader>x :JupyterSendCell<CR>
nnoremap <buffer> <silent> <localleader>e :JupyterSendRange<CR>
vmap     <buffer> <silent> <localleader>e <Plug>JupyterRunVisual
nnoremap <buffer> <silent> <localleader>u :JupyterUpdateShell<CR>
" kill kernel
nnoremap <buffer> <silent> <localleader>k :JupyterTerminateKernel<CR>
" Debugging maps
nnoremap <buffer> <silent> <localleader>b :PythonSetBreak<CR>
hi! link JupyterCell Comment


" -- folds --
set foldmethod=marker
nnoremap <space> za
nmap <Tab> zj
nmap <S-Tab> zk
" create new folds by visual select + space
vnoremap <Space> zf

set timeout ttimeoutlen=100


" -- vimwiki --
let g:wiki_root = '~/vimwiki'
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
autocmd FileType vimwiki nnoremap <buffer> <Leader>wx :VimwikiToggleListItem<CR>
autocmd FileType vimwiki nnoremap <buffer> <Leader>wn :VimwikiRenameFile<CR>
highlight CustomRegion guifg=#ff0000 gui=bold ctermfg=red cterm=bold
augroup vimwiki
	syn region CustomRegion start=/rrx/ end=/xrr/
augroup END
nnoremap <leader>wj :WikiJournal<CR>
nnoremap <leader>wp :WikiPages<CR>
nnoremap <leader>wt :WikiTable<CR>

set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set backspace=indent,eol,start
set clipboard=unnamed
set wildmode=longest,list,full
set wildmenu
"set scrolloff=8
set splitright
set splitbelow
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
" move vertically by visual line
nnoremap j gj
nnoremap k gk

" switch tabs
nnoremap gh gT
nnoremap gl gt

nmap S ysiw


hi IncSearch cterm=NONE ctermfg=yellow ctermbg=green
hi MatchParen gui=none guibg=#004020 guifg=#DDDDDD
let g:python_highlight_all = 1

]])

local keymap = vim.keymap.set

---- Visual mode mappings
--keymap("v", '"', 'S"')
--keymap("v", "'", "S'")
---- Normal mode surrounds
--keymap("n", '"', 'ysiw"')
--keymap("n", "'", "ysiw'")
--keymap("n", "s", "ysiw")

vim.opt.title = true
vim.opt.titlestring = "%t"


