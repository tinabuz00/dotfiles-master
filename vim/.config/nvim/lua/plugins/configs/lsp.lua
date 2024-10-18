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

local ensure_installed = {
	"basedpyright@1.15.2",
	--"yamlls",
	"lua_ls",
	"ts_ls",
	"jsonls",
	"html",
	"cssls",
	"bashls",
	"vimls",
	"dockerls",
	"clangd",
	"sqlls",
	"tailwindcss",
	"jdtls",
}

local server_configs = {
	pyright = {
		settings = {
			python = {
				pythonPath = get_python_path(), -- Get the current Python path dynamically
				analysis = {
					autoSearchPaths = true,
					useLibraryCodeForTypes = true,
					extraPaths = {
					},
				},
			},
		},
	},

	basedpyright = {
		settings = {
			python = {
				pythonPath = get_python_path(), -- Get the current Python path dynamically
				analysis = {
					autoSearchPaths = true,
					useLibraryCodeForTypes = true,
					extraPaths = {
					},
				},
			},
			basedpyright = {
				typeCheckingMode = "standard",
			},
		},
	},

	yamlls = {
		settings = {
			yaml = {
				schemas = {
					["https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/schemas/json/yamllint.json"] = "*.yaml",
				},
			},
		},
	},

	lua_ls = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				hint = {
					enable = true,
				},
			},
		},
	},
}

local function lsp_keymaps(bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	local map = function(keys, func, desc, mode)
		mode = mode or "n"
		vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
	end

	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set(
		"n",
		"gvd",
		'<cmd>lua require"telescope.builtin".lsp_definitions({jump_type="vsplit"})<CR>',
		{ noremap = true, silent = true }
	) -- jump to definition in vertical split
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help, bufopts)

	-- jump to the definition of the word under your cursor.
	--  this is where a variable was first declared, or where a function is defined, etc.
	--  to jump back, press <c-t>.
	vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	map("gd", require("telescope.builtin").lsp_definitions, "[g]oto [d]efinition")
	map("gr", require("telescope.builtin").lsp_references, "[g]oto [r]eferences")
	map("gi", require("telescope.builtin").lsp_implementations, "[g]oto [i]mplementation")
	map("<leader>d", require("telescope.builtin").lsp_type_definitions, "type [d]efinition")
	map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[d]ocument [s]ymbols")
	map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[w]orkspace [s]ymbols")
	map("<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame")
	map("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction", { "n", "x" })
	map("gd", vim.lsp.buf.declaration, "[g]oto [d]eclaration")

	vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)

	-- toggle inlay hints
	vim.keymap.set("n", "<leader>ih", function()
		local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
		vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = bufnr })
	end, bufopts)
end

-- Highlight symbol under cursor
local function lsp_highlight(client, bufnr)
	vim.cmd([[
	  highlight! DiagnosticLineNrError guibg=#3B2628 guifg=#FF808a gui=bold
	  highlight! DiagnosticLineNrWarn guibg=#3F3128 guifg=#FFA544 gui=bold
	  highlight! DiagnosticLineNrInfo guibg=#1E535D guifg=#33FFDD gui=bold
	  highlight! DiagnosticLineNrHint guibg=#1E205D guifg=#44AAFF gui=bold
	]])

	vim.diagnostic.config({
		virtual_text = false,
		signs = {
			enables = true,
			text = {
				[vim.diagnostic.severity.ERROR] = "",
				[vim.diagnostic.severity.WARN] = "⚠",
				[vim.diagnostic.severity.INFO] = "ⓘ",
				[vim.diagnostic.severity.HINT] = "☛",
			},
			texthl = {
				[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
				[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
				[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
				[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
			},
			numhl = {
				[vim.diagnostic.severity.WARN] = "DiagnosticLineNrWarn",
				[vim.diagnostic.severity.ERROR] = "DiagnosticLineNrError",
				[vim.diagnostic.severity.INFO] = "DiagnosticLineNrInfo",
				[vim.diagnostic.severity.HINT] = "DiagnosticLineNrHint",
			},
		},
		update_in_insert = false,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "solid",
			source = "always",
			header = "",
			prefix = "",
		},
	})
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
end

local on_attach = function(client, bufnr)
	lsp_keymaps(bufnr)
	lsp_highlight(client, bufnr)
	require("lsp-status").on_attach(client)
	client.server_capabilities.semanticTokensProvider = nil
	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end
end

return {
	-- Main LSP Configuration
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"nvim-lua/lsp-status.nvim",
		"mfussenegger/nvim-jdtls",

		{ "j-hui/fidget.nvim", opts = {} },

		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		-- LSP servers and clients are able to communicate to each other what features they support.
		--  By default, Neovim doesn't support everything that is in the LSP specification.
		--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
		--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		require("mason").setup()

		require("mason-lspconfig").setup({
			ensure_installed = ensure_installed,
			handlers = {
				function(server_name)
					local capab = require("cmp_nvim_lsp").default_capabilities()
					capab = vim.tbl_extend("keep", capab or {}, require("lsp-status").capabilities)
					capab.offsetEncoding = { "utf-16" }

					local opts = {
						on_attach = on_attach,
						capabilities = capab,
					}
					-- Extend options with server-specific configuration if available
					if server_configs[server_name] then
						opts = vim.tbl_deep_extend("force", opts, server_configs[server_name])
					end

					require("lspconfig")[server_name].setup(opts)
				end,

				['jdtls'] = function() end,
			},
		})
		-- run LspStart
		vim.cmd("LspStart")
	end,
}
