local opt = vim.opt

-- Function to get the current Python path
local function get_python_path()
	local handle = io.popen("which python")
	if handle == nil then
		print("Pythonpath not found")
		return ""
	end
	local python_path = handle:read("*a")
	handle:close()
	return python_path:gsub("%s+", "") -- Remove any trailing newline characters
end
-- General settings
opt.mouse = "a"
opt.clipboard = "unnamed"
opt.wildmode = "longest,list,full"
opt.wildmenu = true
opt.scrolloff = 8
opt.splitright = true
opt.splitbelow = true

-- Search settings
opt.incsearch = true
opt.hlsearch = true

-- Indentation settings
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = false

-- Appearance
opt.number = true
opt.termguicolors = true

-- Undo and backup settings
opt.undofile = true
opt.backup = true
opt.writebackup = true
opt.undolevels = 1000000
opt.undoreload = 1000000
opt.undodir = vim.fn.expand("~/.vim/.undo//")
opt.backupdir = vim.fn.expand("~/.vim/.backup//")
opt.directory = vim.fn.expand("~/.vim/.swp//")

-- Other settings
opt.backspace = "indent,eol,start"

-- Python host prog
--vim.g.python3_host_prog = "/opt/homebrew/Caskroom/miniconda/base/envs/py311/bin/python"
vim.g.python3_host_prog = get_python_path()

-- Conda startup message
vim.g.conda_startup_msg_suppress = 1
