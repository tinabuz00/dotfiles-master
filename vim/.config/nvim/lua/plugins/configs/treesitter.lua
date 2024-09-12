require("nvim-treesitter").setup({
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
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
	},
})

-- for some reason I have to manually enable these...
vim.cmd("TSEnable highlight")
vim.cmd("TSEnable indent")
