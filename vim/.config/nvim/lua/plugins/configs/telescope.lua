local Path = require("plenary.path")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local open_using = function(finder)
	return function(prompt_bufnr)
		local current_finder = action_state.get_current_picker(prompt_bufnr).finder
		local entry = action_state.get_selected_entry()

		local entry_path
		if entry.ordinal == ".." then
			entry_path = Path:new(current_finder.path)
		else
			entry_path = action_state.get_selected_entry().Path
		end

		local path = entry_path:is_dir() and entry_path:absolute() or entry_path:parent():absolute()
		actions.close(prompt_bufnr)
		finder({ cwd = path })
	end
end

local live_grep = require("telescope.builtin").live_grep
local find_files = require("telescope.builtin").find_files

require("workspaces").setup({
	hooks = {
		open = { "Telescope find_files" },
	},
})

require("dir-telescope").setup({
	-- these are the default options set
	hidden = true,
	no_ignore = false,
	show_preview = true,
})

local pathogen = require("telescope").load_extension("pathogen")

require("telescope").setup({
	defaults = {
		layout_config = { horizontal = { preview_cutoff = 0 } },
		file_ignore_patterns = { "node_modules", "dist", "*.svg", "*.png", "wandb", "__pycache__" },
		mappings = {
			n = {
				["q"] = actions.close,
			},
			i = {
				-- map actions.which_key to <C-h> (default: <C-/>)
				-- actions.which_key shows the mappings for your picker,
				-- e.g. git_{create, delete, ...}_branch for the git_branches picker
				["<C-h>"] = "which_key",
			},
		},
	},
	pickers = {
		loclist = {
			attach_mappings = function(prompt_bufnr, map)
				map("i", "<C-i>", pathogen.grep_in_result)
				map("i", "<C-e>", pathogen.invert_grep_in_result)
				return true
			end,
		},
		pickers = { colorscheme = { enable_preview = true } },
	},
	extensions = {
		file_browser = {
			-- disables netrw and use telescope-file-browser in its place
			--hijack_netrw = true,
			mappings = {
				["i"] = {
					["<C-f>"] = open_using(find_files),
					["<C-g>"] = open_using(live_grep),
				},
				["n"] = {
					["<C-f>"] = open_using(find_files),
					["<C-g>"] = open_using(live_grep),
				},
			},
		},
	},
})

require("telescope").load_extension("file_browser")
require("telescope").load_extension("ui-select")
require("telescope").load_extension("workspaces")
require("telescope").load_extension("dir")
require("telescope").load_extension("cder")

local builtin = require("telescope.builtin")

local keymap = vim.keymap.set

keymap("n", "ff", "<cmd>Telescope pathogen find_files<CR>", { noremap = true, silent = true })
keymap("n", "fg", "<cmd>Telescope pathogen live_grep<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "fb", builtin.buffers, {})
vim.keymap.set("n", "fh", builtin.help_tags, {})
vim.keymap.set("n", "ft", builtin.tags, {})
vim.keymap.set("n", "fs", builtin.lsp_dynamic_workspace_symbols, {})
vim.keymap.set("n", "gi", builtin.lsp_implementations, {})

