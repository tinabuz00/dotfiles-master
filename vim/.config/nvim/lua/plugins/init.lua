local plugins = {
	{ lazy = true, "nvim-lua/plenary.nvim" },
	{ "neanias/everforest-nvim" },
	{ "jupyter-vim/jupyter-vim" },
	{ "mfussenegger/nvim-dap" },

	{
		--"ayu-theme/ayu-vim",
		"Shatur/neovim-ayu",
		--"luxed/ayu-vim",
		lazy = false, -- make sure we load this during startup
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.cmd.set("background=dark")
			vim.cmd.colorscheme("ayu")
			vim.cmd([[hi normal guibg=#151515]])
			vim.cmd([[hi @multilinestring guifg=#aabbba]])
		end,
	},
	{ "rebelot/kanagawa.nvim", priority = 1000 },
	-- icons, for UI related plugins
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup()
		end,
	},
	{
		"nvim-zh/colorful-winsep.nvim",
		event = { "WinLeave" },
		config = function()
			require("colorful-winsep").setup({ smooth = false })
		end,
	},

	{
		"folke/noice.nvim",

		event = "VeryLazy",
		config = function()
			require("noice").setup({

				routes = {
					{
						filter = {
							event = "msg_show",
							kind = "",
							find = "more line",
						},
						opts = { skip = true },
					},
				},
				notify = {
					enabled = false,
				},
				lsp = {
					hover = {
						enabled = false,
					},
					signature = {
						enabled = false,
					},
					message = {
						enabled = false,
					},
				},
				presets = {
					command_palette = true,
				},
				views = {
					cmdline_popup = {
						border = {
							style = "none",
							padding = { 2, 3 },
						},
						position = {
							row = -10,
							col = 10,
						},
						size = {
							width = 70,
							height = "auto",
						},

						filter_options = {},
						win_options = {
							winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
						},
					},
				},
			})
		end,
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			--config.lsp.hover.enabled = false,
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			--"rcarriga/nvim-notify",
		},
	},

	{
		"alvarosevilla95/luatab.nvim",
		config = function()
			require("luatab").setup()
		end,
	},

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		config = function()
			require("todo-comments").setup()
			vim.keymap.set("n", "ft", ":TodoTelescope<CR>")
		end,
	},

	--{
	--"edluffy/hologram.nvim",
	--config = function()
	--require("hologram").setup({
	--auto_display = true, -- WIP automatic markdown image display, may be prone to breaking
	--})
	--end,
	--},

	{
		"tonymajestro/smart-scrolloff.nvim",
		opts = {
			scrolloff_percentage = 0.2,
		},
	},

	{
		"opdavies/toggle-checkbox.nvim",
		config = function()
			vim.keymap.set("n", "<leader>tt", ":lua require('toggle-checkbox').toggle()<CR>")
		end,
	},
	{ "nvim-treesitter/playground" },
	-- syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("plugins.configs.treesitter")
		end,
	},
	{
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({
				delay = 0, -- delay in milliseconds before highlighting
				filetypes_denylist = { "dirvish", "fugitive" },
				providers = { "lsp", "treesitter", "regex" },
			})
		end,
	},

	{ "nvim-treesitter/nvim-treesitter-context" },

	--{ "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },
	{
		"nanozuki/tabby.nvim",
		-- event = 'VimEnter', -- if you want lazy load, see below
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			-- configs...
		end,
	},

	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			require("dapui").setup()
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			--require("dapui").close()
			vim.keymap.set("n", "dc", function()
				require("dapui").toggle()
			end)
		end,
	},

	--{
	--"folke/neodev.nvim",
	--dependencies = { "rcarriga/nvim-dap-ui" },
	--opts = {},
	--config = function()
	--require("neodev").setup({
	--library = { plugins = { "nvim-dap-ui" }, types = true },
	--})
	--end,
	--},

	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("nvim-dap-virtual-text").setup({
				all_references = false, -- show virtual text on all all references of the variable (not only definitions)
				virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",

				-- experimental features:
				all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
				virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
				virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
				-- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
			})
		end,
	},

	{
		"nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			require("dap-python").setup("python")
			require("dap-python").test_runner = "pytest"
			require("dap").defaults.python.exception_breakpoints = { "raised" }

			vim.keymap.set("n", "<F8>", function()
				require("dap").continue()
			end)
			vim.keymap.set("n", "<F9>", function()
				require("dap").step_over()
			end)
			vim.keymap.set("n", "<F4>", function()
				require("dap").step_into()
			end)
			vim.keymap.set("n", "<F7>", function()
				require("dap").step_out()
			end)
			vim.keymap.set("n", "<Leader>b", function()
				require("dap").toggle_breakpoint()
			end)
			vim.keymap.set("n", "<Leader>B", function()
				require("dap").set_breakpoint()
			end)
			vim.keymap.set("n", "<Leader>lp", function()
				require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end)
			vim.keymap.set("n", "<Leader>dr", function()
				require("dap").repl.open()
			end)
			vim.keymap.set("n", "<Leader>dl", function()
				require("dap").run_last()
			end)
			vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
				require("dap.ui.widgets").hover()
			end)
			vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
				require("dap.ui.widgets").preview()
			end)
			vim.keymap.set("n", "<Leader>df", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.frames)
			end)
			vim.keymap.set("n", "<Leader>ds", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end)

			vim.keymap.set("n", "<leader>df", function()
				require("dap-python").test_method()
			end)
			vim.keymap.set("v", "<leader>ds", function()
				require("dap-python").debug_selection()
			end)
		end,
	},

	{
		"Aasim-A/scrollEOF.nvim", -- scroll past end of file to maintain scrolloff
		event = { "CursorMoved", "WinScrolled" },
		opts = {},
	},

	{
		"mcauley-penney/visual-whitespace.nvim", -- reveal whitespace in visual mode
		config = true,
	},

	{ "nvim-lua/popup.nvim" },
	{ "tpope/vim-surround" },
	{ "scrooloose/nerdcommenter" },
	{ "godlygeek/tabular" },
	{
		"lervag/wiki.vim",
		config = function()
			vim.g.wiki_root = "~/vimwiki"
		end,
	},

	{ "jghauser/mkdir.nvim" },
	{ "TabbyML/vim-tabby" },
	{ "stevearc/dressing.nvim" },
	{
		"brenoprata10/nvim-highlight-colors",
		config = function()
			require("nvim-highlight-colors").setup()
		end,
	},
	-- Appearance
	--{ "rafi/awesome-vim-colorschemes" },
	{ "kyazdani42/nvim-web-devicons" },

	{
		"MunifTanjim/nui.nvim",

		config = function()
			local Input = require("nui.input")
			local event = require("nui.utils.autocmd").event

			function ReplaceSelection()
				vim.cmd('normal! gv"hy')
				local selection = vim.fn.getreg("h")
				selection = vim.fn.escape(selection, "\\/.*$^~[]")
				selection = selection:gsub("\n", "\\n")

				local input = Input({
					position = "2",
					size = {
						width = 40,
						height = 3,
					},
					border = {
						style = "single",
						text = {
							top = "[ Replace with ]",
							top_align = "center",
						},
					},
					relative = "cursor", -- This makes the input box appear near the cursor
					win_options = {
						winhighlight = "Normal:Normal,FloatBorder:Normal",
					},
				}, {
					prompt = "",
					default_value = selection,
					on_close = function() end,
					on_submit = function(replacement)
						local cmd = ":%s/" .. selection .. "/" .. replacement .. "/gc"
						vim.cmd(cmd)
					end,
				})

				input:mount()
				input:on(event.BufLeave, function()
					input:unmount()
				end)
			end
			-- Map the function to a keybinding, for example <C-r>, in visual mode
			vim.api.nvim_set_keymap("v", "<C-r>", ":lua ReplaceSelection()<CR>", { noremap = true, silent = true })
		end,
	},

	--{ "rcarriga/nvim-notify" },
	{ "SmiteshP/nvim-navic" },
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = ... },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "rose-pine/neovim", name = "rose-pine", priority = 1000 },

	{ "loctvl842/monokai-pro.nvim", priority = 1000 },
	{ "folke/tokyonight.nvim", priority = 1000 },
	{ "folke/lsp-colors.nvim" },

	--{
	--"folke/styler.nvim",
	--config = function()
	--require("styler").setup({
	--themes = {
	--yaml = { colorscheme = "gruvbox", background = "dark" },
	--},
	--})
	--end,
	--},

	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		opts = {},
	},

	-- Navigation
	{ "jimsei/winresizer" },
	{ "christoomey/vim-tmux-navigator" },
	{ "mbbill/undotree" },
	{ "folke/which-key.nvim" },

	{ "nvim-lua/lsp-status.nvim" },

	-- Menus
	{ "sunjon/stylish.nvim" },
	{ "meznaric/conmenu" },
	{ "3rd/image.nvim" },

	{ "kevinhwang91/nvim-ufo" },
	{ "HiPhish/debugpy.nvim" },
	{ "kevinhwang91/promise-async" },
	{
		"SirVer/ultisnips",
		event = "InsertEnter",
		config = function()
			vim.g.UltiSnipsExpandTrigger = "<C-o>"
			vim.g.UltiSnipsJumpForwardTrigger = "<C-b>"
			vim.g.UltiSnipsJumpBackwardTrigger = "<C-x>"
			vim.g.UltiSnipsEditSplit = "horizontal"
		end,
	},

	{
		"MeanderingProgrammer/render-markdown.nvim",
		config = function()
			require("render-markdown").setup({
				file_types = { "Avante", "markdown" },
				quote = {
					-- Turn on / off block quote & callout rendering
					enabled = true,
					-- Replaces '>' of 'block_quote'
					icon = "┃",
					-- Whether to repeat icon on wrapped lines. Requires neovim >= 0.10. This will obscure text if
					-- not configured correctly with :h 'showbreak', :h 'breakindent' and :h 'breakindentopt'. A
					-- combination of these that is likely to work is showbreak = '  ' (2 spaces), breakindent = true,
					-- breakindentopt = '' (empty string). These values are not validated by this plugin. If you want
					-- to avoid adding these to your main configuration then set them in win_options for this plugin.
					repeat_linebreak = false,
					-- Highlight for the quote icon
					highlight = "RenderMarkdownQuote",
				},
				heading = {
					-- Turn on / off heading icon & background rendering
					enabled = true,
					-- Turn on / off any sign column related rendering
					sign = true,
					-- Determines how icons fill the available space:
					--  inline:  underlying '#'s are concealed resulting in a left aligned icon
					--  overlay: result is left padded with spaces to hide any additional '#'
					position = "overlay",
					-- Replaces '#+' of 'atx_h._marker'
					-- The number of '#' in the heading determines the 'level'
					-- The 'level' is used to index into the array using a cycle
					--icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
					icons = { "▰ ", "▰  ", "▰  ", "▰   ", "▰   ", "▰    " },
					-- Added to the sign column if enabled
					-- The 'level' is used to index into the array using a cycle
					signs = { "󰫎 " },
					-- Width of the heading background:
					--  block: width of the heading text
					--  full:  full width of the window
					-- Can also be an array of the above values in which case the 'level' is used
					-- to index into the array using a clamp
					width = "block",
					-- Amount of padding to add to the left of headings
					left_pad = 0,
					-- Amount of padding to add to the right of headings when width is 'block'
					right_pad = 5,
					-- Minimum width to use for headings when width is 'block'
					min_width = 60,
					-- Determins if a border is added above and below headings
					border = false,
					-- Highlight the start of the border using the foreground highlight
					border_prefix = false,
					-- Used above heading for border
					above = "▄",
					-- Used below heading for border
					below = "▀",
					-- The 'level' is used to index into the array using a clamp
					-- Highlight for the heading icon and extends through the entire line
					backgrounds = {
						"RenderMarkdownH1Bg",
						"RenderMarkdownH2Bg",
						"RenderMarkdownH3Bg",
						"RenderMarkdownH4Bg",
						"RenderMarkdownH5Bg",
						"RenderMarkdownH6Bg",
					},
					-- The 'level' is used to index into the array using a clamp
					-- Highlight for the heading and sign icons
					foregrounds = {
						"RenderMarkdownH1",
						"RenderMarkdownH2",
						"RenderMarkdownH3",
						"RenderMarkdownH4",
						"RenderMarkdownH5",
						"RenderMarkdownH6",
					},
				},
			})
		end,
	},

	{
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup()
			vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("plugins.configs.lualine")
		end,
	},
	{
    'fei6409/log-highlight.nvim',
    config = function()
        require('log-highlight').setup {}
    end,
	},

	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- cmp sources
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-cmdline",
		},
		config = function()
			require("plugins.configs.cmp")
		end,
	},
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "andersevenrud/cmp-tmux" },
	{ "hrsh7th/cmp-nvim-lsp-signature-help" },

	{
		"gbprod/substitute.nvim",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		config = function()
			require("substitute").setup()
			vim.keymap.set("n", "s", require("substitute").operator, { noremap = true })
			vim.keymap.set("n", "ss", require("substitute").line, { noremap = true })
			vim.keymap.set("n", "S", require("substitute").eol, { noremap = true })
			vim.keymap.set("x", "s", require("substitute").visual, { noremap = true })
		end,
	},

	require("plugins.configs.lsp"),

	require("plugins.configs.alpha"),

	{
		"rmagatti/goto-preview",
		event = "BufEnter",
		config = function()
			require("goto-preview").setup({
				width = 110, -- Width of the floating window
				height = 25, -- Height of the floating window
				border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" }, -- Border characters of the floating window
				default_mappings = false, -- Bind default mappings
				debug = false, -- Print debug information
				opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
				resizing_mappings = true, -- Binds arrow keys to resizing the floating window.
				post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
				post_close_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
				references = { -- Configure the telescope UI for slowing the references cycling window.
					telescope = require("telescope.themes").get_dropdown({ hide_preview = false }),
				},
				-- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
				focus_on_open = true, -- Focus the floating window when opening it.
				dismiss_on_move = false, -- Dismiss the floating window when moving the cursor.
				force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
				bufhidden = "wipe", -- the bufhidden option to set on the floating window. See :h bufhidden
				stack_floating_preview_windows = true, -- Whether to nest floating windows
				preview_window_title = { enable = true, position = "left" }, -- Whether to set the preview window title as the filename
				zindex = 1, -- Starting zindex for the stack of floating windows
			})

			vim.cmd([[
			nnoremap fd <cmd>lua require('goto-preview').goto_preview_definition()<CR>
			nnoremap ft <cmd>lua require('goto-preview').goto_preview_type_definition()<CR>
			nnoremap fi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>
			nnoremap fD <cmd>lua require('goto-preview').goto_preview_declaration()<CR>
			nnoremap fx <cmd>lua require('goto-preview').close_all_win()<CR>
			nnoremap fr <cmd>lua require('goto-preview').goto_preview_references()<CR>
			]])
		end,
	},

	{
		-- database UI
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql", "sqlite" }, lazy = true },
		},
		cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
		init = function()
			vim.g.db_ui_use_nerd_fonts = 1
		end,
		config = function()
			vim.g.db_ui_auto_execute_table_helpers = 1
		end,

		keys = {
			{ "<leader>db", "<cmd>DBUIToggle<CR>", desc = "Toggle DB UI" },
		},
	},

	-- indent lines
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("ibl").setup({
				indent = { char = "│" },
				scope = { char = "│", highlight = "Comment" },
			})
		end,
	},

	-- Telescope
	{ "natecraddock/workspaces.nvim" },
	{ "princejoogie/dir-telescope.nvim" },
	{ "zane-/cder.nvim" },
	{ "brookhong/telescope-pathogen.nvim" },
	{ "nvim-telescope/telescope-file-browser.nvim" },
	{ "nvim-telescope/telescope-ui-select.nvim" },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{
				"telescope-pathogen.nvim",
				"natecraddock/workspaces.nvim",
				"princejoogie/dir-telescope.nvim",
				"telescope-file-browser.nvim",

			{
				"nvim-telescope/telescope-fzf-native.nvim",
					  build = "make",
					  config = function()
						require("telescope").load_extension("fzf")
					  end,
					},

				"telescope-ui-select.nvim",
				"zane-/cder.nvim",
			},
		},
		cmd = "Telescope",
		config = function()
			require("plugins.configs.telescope")
		end,
	},
	{
		"folke/persistence.nvim",
		enabled = true,
	},
	{
		"olimorris/persisted.nvim",
		lazy = false, -- make sure the plugin is always loaded at startup
		opts = {
			save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/persisted-session/"), -- Resolves to ~/.local/share/nvim/persisted-sessions/
			use_git_branch = true,
			silent = true,
			should_autosave = function()
				-- Ignore certain filetypes from autosaving
				local excluded_filetypes = {
					"alpha",
					"oil",
					"lazy",
					"toggleterm",
					"",
				}

				for _, filetype in ipairs(excluded_filetypes) do
					if vim.bo.filetype == filetype then
						return false
					end
				end

				return true
			end,
		},
		config = function(_, options)
			require("persisted").setup(options)

			local ok, telescope = pcall(require, "telescope")
			if not ok then
				return
			end
			telescope.load_extension("persisted")
		end,
	},

	{ "echasnovski/mini.surround", version = "*" },

	-- git status on signcolumn etc
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
				numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
				linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
				word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
				watch_gitdir = {
					follow_files = true,
				},
			})
		end,
	},

	{
		"mhartington/formatter.nvim",
		config = function()
			require("plugins.configs.format")
		end,
	},

	{
		"jake-stewart/multicursor.nvim",
		branch = "1.0",
		config = function()
			local mc = require("multicursor-nvim")

			mc.setup()

			-- Add cursors above/below the main cursor.
			vim.keymap.set({ "n", "v" }, "<up>", function()
				mc.addCursor("k")
			end)
			vim.keymap.set({ "n", "v" }, "<down>", function()
				mc.addCursor("j")
			end)

			-- Add a cursor and jump to the next word under cursor.
			vim.keymap.set({ "n", "v" }, "<c-n>", function()
				mc.addCursor("*")
			end)

			-- Jump to the next word under cursor but do not add a cursor.
			vim.keymap.set({ "n", "v" }, "<c-s>", function()
				mc.skipCursor("*")
			end)

			-- Rotate the main cursor.
			vim.keymap.set({ "n", "v" }, "<left>", mc.nextCursor)
			vim.keymap.set({ "n", "v" }, "<right>", mc.prevCursor)

			-- Delete the main cursor.
			vim.keymap.set({ "n", "v" }, "<leader>x", mc.deleteCursor)

			-- Add and remove cursors with control + left click.
			vim.keymap.set("n", "<c-leftmouse>", mc.handleMouse)

			vim.keymap.set({ "n", "v" }, "<c-q>", function()
				if mc.cursorsEnabled() then
					-- Stop other cursors from moving.
					-- This allows you to reposition the main cursor.
					mc.disableCursors()
				else
					mc.addCursor()
				end
			end)

			vim.keymap.set("n", "<esc>", function()
				if not mc.cursorsEnabled() then
					mc.enableCursors()
				elseif mc.hasCursors() then
					mc.clearCursors()
				else
					-- Default <esc> handler.
				end
			end)

			-- Align cursor columns.
			vim.keymap.set("n", "<leader>a", mc.alignCursors)

			-- Split visual selections by regex.
			vim.keymap.set("v", "S", mc.splitCursors)

			-- Append/insert for each line of visual selections.
			vim.keymap.set("v", "I", mc.insertVisual)
			vim.keymap.set("v", "A", mc.appendVisual)

			-- match new cursors within visual selections by regex.
			vim.keymap.set("v", "M", mc.matchCursors)

			-- Rotate visual selection contents.
			vim.keymap.set("v", "<leader>t", function()
				mc.transposeCursors(1)
			end)
			vim.keymap.set("v", "<leader>T", function()
				mc.transposeCursors(-1)
			end)

			-- Customize how cursors look.
			vim.api.nvim_set_hl(0, "MultiCursorCursor", { link = "Cursor" })
			vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "Visual" })
			vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
			vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
		end,
	},

}

require("lazy").setup({
	plugins,
})
