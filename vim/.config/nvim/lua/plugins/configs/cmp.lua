local cmp = require("cmp")

vim.cmd([[highlight CmpDocumentation guibg=#111111]])
vim.cmd([[highlight CmpDocumentationBorder guibg=#111111 guifg=#777777]])
vim.cmd([[highlight CmpItemAbbr guifg=#cccccc]])
vim.cmd([[highlight CmpItemMenu guifg=#444444]])
vim.cmd([[highlight PmenuSel guibg=#333333]])
vim.cmd([[hi link CmpItemKind Function]])

local source_icon = {
	nvim_lsp = " ",
	luasnip = "⋗ ",
	ultisnips = " ",
	buffer = ". ",
	tmux = " ",
	path = " ",
	nvim_lua = " ",
}


local kind_icon = {
	Text = "",
	Method = "",
	Function = "ƒ",
	Constructor = "",
	Field = "⌘",
	Variable = "x",
	Class = "",
	Interface = "I",
	Module = "",
	Property = "",
	Unit = "",
	Value = "y",
	Enum = "了",
	Keyword = "",
	Snippet = "S",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

cmp.setup({
	sources = {
		{ name = "copilot" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "buffer" },
		{ name = "tmux" },
		{ name = "ultisnips" },
	},
	mapping = cmp.mapping.preset.insert({
		--["<C-k>"] = cmp.mapping.select_prev_item(),
		--["<C-j>"] = cmp.mapping.select_next_item(),
		--["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1)),
		--["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1)),
		--["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<C-Enter>"] = cmp.mapping.confirm({ select = false }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, {
			"i",
			"s",
			"c",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, {
			"i",
			"s",
			"c",
		}),
	}),
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		completion = cmp.config.window.bordered({
			winhighlight = "Normal:CmpDocumentation,FloatBorder:CmpDocumentationBorder,CursorLine:PmenuSel,Search:None",
			border = "rounded",
		}),
		documentation = cmp.config.window.bordered({
			max_height = 30,
			max_width = 60,
			border = "rounded",
			col_offset = 2,
			side_padding = 3,
			winhighlight = "Normal:CmpDocumentation,FloatBorder:CmpDocumentationBorder,CursorLine:Visual,Search:None",
		}),
	},

	formatting = {
		fields = { "menu", "abbr", "kind" },
		format = function(entry, item)
			item.menu = source_icon[entry.source.name]
			item.kind = kind_icon[item.kind] or item.kind
			return item
		end,
	},

	experimental = {
		ghost_text = false,
	},
})

local devicons = require("nvim-web-devicons")
cmp.register_source("devicons", {
	complete = function(self, params, callback)
		local items = {}
		for _, icon in pairs(devicons.get_icons()) do
			table.insert(items, {
				label = icon.icon .. "  " .. icon.name,
				insertText = icon.icon,
				filterText = icon.name,
			})
		end
		callback({ items = items })
	end,
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "cmdline" },
		{ name = "path" },
	},
	window = {
		completion = cmp.config.window.bordered({
			border = "rounded",
			winhighlight = "Normal:Normal,FloatBorder:CmpCompletionBorder,CursorLine:CmpCursorLine,Search:Search",
			col_offset = -3,
			side_padding = 1,
		}),
	},
})
