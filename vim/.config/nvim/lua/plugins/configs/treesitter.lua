require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"lua",
		"vim",
		"vimdoc",
		"html",
		"css",
		"markdown",
		"markdown_inline",
		"dockerfile",
		"toml",
		"jsonc",
		"typescript",
		"javascript",
		"yaml",
		"python",
		"json",
		"c",
		"cpp",
		"rust",
		"bash",
		"go",
		"latex",
		"java",
		"regex",
		"sql",
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true },

	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<CR>",
			scope_incremental = "<CR>",
			node_decremental = "<TAB>",
			node_incremental = ".",
		},
	},
})

-- for some reason I have to manually enable these...
vim.cmd("TSEnable highlight")
vim.cmd("TSEnable indent")
