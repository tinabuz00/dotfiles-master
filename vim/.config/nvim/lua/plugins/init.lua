local plugins = {
	{ lazy = true, "nvim-lua/plenary.nvim" },
	{ "neanias/everforest-nvim" },

	--{
	--"Shatur/neovim-ayu",
	--lazy = false, -- make sure we load this during startup
	--priority = 1000, -- make sure to load this before all the other start plugins
	--config = function()
	--require("ayu").setup({
	--overrides = {
	--Normal = { bg = "#151515", fg = "#ffffff" },
	----link variable to normal:
	--},
	--})
	--vim.cmd.set("background=dark")
	--vim.cmd.colorscheme("ayu")
	--vim.cmd([[hi Normal guibg=#151515 guifg=#ffffff ]])
	--vim.cmd([[hi Variable guifg=#ffffff ]])
	--vim.cmd([[hi @multilinestring guifg=#aabbba]])
	--end,
	--},

	{
		"ayu-theme/ayu-vim",
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

	-- icons, for UI related plugins
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup()
		end,
	},

	{
		"alvarosevilla95/luatab.nvim",
		config = function()
			require("luatab").setup()
		end,
	},

	{
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({
				delay = 5,
			})
		end,
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

	{ "jupyter-vim/jupyter-vim" },

	--{
	--"nvim-zh/colorful-winsep.nvim", -- colorful window separator
	--config = true,
	--event = { "WinLeave" },
	--},

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
	{ "MunifTanjim/nui.nvim" },
	{ "rcarriga/nvim-notify" },
	{ "SmiteshP/nvim-navic" },

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

	{ "loctvl842/monokai-pro.nvim" },
	{ "folke/lsp-colors.nvim" },

	-- Navigation
	{ "jimsei/winresizer" },
	{ "christoomey/vim-tmux-navigator" },
	{ "mbbill/undotree" },
	{ "folke/which-key.nvim" },

	{ "andersevenrud/cmp-tmux" },
	{ "hrsh7th/cmp-nvim-lsp-signature-help" },
	{ "nvim-lua/lsp-status.nvim" },

	-- Menus
	{ "sunjon/stylish.nvim" },
	{ "meznaric/conmenu" },
	{ "3rd/image.nvim" },

	-- Language syntax
	--{ "sheerun/vim-polyglot" },
	--{ "jackguo380/vim-lsp-cxx-highlight" },
	--{ "tikhomirov/vim-glsl" },
	--{ "octol/vim-cpp-enhanced-highlight" },
	--{ "vim-python/python-syntax" },
	--{ "pangloss/vim-javascript" },
	--{ "leafgarland/typescript-vim" },
	--{ "peitalin/vim-jsx-typescript" },
	--{ "maxmellon/vim-jsx-pretty" },
	--{ "styled-components/vim-styled-components", branch = "main" },

	{ "kevinhwang91/nvim-ufo" },
	{ "mfussenegger/nvim-dap" },
	{ "theHamsta/nvim-dap-virtual-text" },
	{ "mfussenegger/nvim-dap-python" },
	{ "HiPhish/debugpy.nvim" },
	{ "kevinhwang91/promise-async" },
	{ "yetone/avante.nvim" },
	{
		"SirVer/ultisnips",
		event = "InsertEnter",
		config = function()
			vim.g.UltiSnipsExpandTrigger = "<C-o>"
			vim.g.UltiSnipsJumpForwardTrigger = "<C-b>"
			vim.g.UltiSnipsJumpBackwardTrigger = "<C-x>"
			vim.g.UltiSnipsEditSplit = "horizontal"
			--vim.g.UltiSnipsSnippetDirectories = { "~/.vim/UltiSnips" }
		end,
	},

	{
		"MeanderingProgrammer/render-markdown.nvim",
		config = function()
			require("render-markdown").setup({
				file_types = { "Avante", "python", "markdown" },
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

	-- we use cmp plugin only when in insert mode
	-- so lets lazyload it at InsertEnter event, to know all the events check h-events
	-- completion , now all of these plugins are dependent on cmp, we load them after cmp
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

			--{
			--"windwp/nvim-autopairs",
			--config = function()
			--require("nvim-autopairs").setup()
			--local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			--local cmp = require("cmp")
			--cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
			--end,
			--},
		},
		config = function()
			require("plugins.configs.cmp")
		end,
	},
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
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },

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
	{ "nvim-telescope/telescope-fzf-native.nvim" },
	{ "nvim-telescope/telescope-ui-select.nvim" },
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{
				"telescope-pathogen.nvim",
				"natecraddock/workspaces.nvim",
				"princejoogie/dir-telescope.nvim",
				"telescope-file-browser.nvim",
				"telescope-fzf-native.nvim",
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
		"github/copilot.vim",
		event = "InsertEnter",
		config = function()
			require("plugins.configs.copilot")
			vim.cmd("Copilot")
		end,
	},
	{
		"mhartington/formatter.nvim",
		config = function()
			require("plugins.configs.format")
		end,
	},

	--{
	--"yetone/avante.nvim",
	--event = "VeryLazy",
	--lazy = false,
	--version = false, -- set this if you want to always pull the latest change
	--opts = {},
	--build = "make",
	--dependencies = {
	--"stevearc/dressing.nvim",
	--"nvim-lua/plenary.nvim",
	--"MunifTanjim/nui.nvim",
	--"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
	----"zbirenbaum/copilot.lua", -- for providers='copilot'
	--{
	---- support for image pasting
	--"HakonHarnes/img-clip.nvim",
	--event = "VeryLazy",
	--opts = {
	---- recommended settings
	--default = {
	--embed_image_as_base64 = false,
	--prompt_for_file_name = false,
	--drag_and_drop = {
	--insert_mode = true,
	--},
	---- required for Windows users
	--use_absolute_path = true,
	--},
	--},
	--},
	--},
	--},

	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			debug = false, -- Enable debug logging
			proxy = nil, -- [protocol://]host[:port] Use this proxy
			allow_insecure = false, -- Allow insecure server connections

			model = "gpt-4o", -- GPT model to use, 'gpt-3.5-turbo', 'gpt-4', or 'gpt-4o'
			temperature = 0.1, -- GPT temperature

			show_folds = true, -- Shows folds for sections in chat
			show_help = true, -- Shows help message as virtual lines when waiting for user input
			auto_follow_cursor = true, -- Auto-follow cursor in chat
			auto_insert_mode = false, -- Automatically enter insert mode when opening window and on new prompt
			insert_at_end = false, -- Move cursor to end of buffer when inserting text
			clear_chat_on_new_prompt = false, -- Clears chat on every new prompt
			highlight_selection = true, -- Highlight selection in the source buffer when in the chat window

			context = nil, -- Default context to use, 'buffers', 'buffer' or none (can be specified manually in prompt via @).
			history_path = vim.fn.stdpath("data") .. "/copilotchat_history", -- Default path to stored history
			callback = nil, -- Callback to use when ask response is received

			-- default window options
			window = {
				layout = "vertical", -- 'vertical', 'horizontal', 'float', 'replace'
				width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
				height = 0.5, -- fractional height of parent, or absolute height in rows when > 1
				-- Options below only apply to floating windows
				relative = "editor", -- 'editor', 'win', 'cursor', 'mouse'
				border = "single", -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
				row = nil, -- row position of the window, default is centered
				col = nil, -- column position of the window, default is centered
				title = "Copilot Chat", -- title of chat window
				footer = nil, -- footer of chat window
				zindex = 1, -- determines if window is on top or below other floating windows
			},

			-- default mappings
			mappings = {
				complete = {
					detail = "Use @<Tab> or /<Tab> for options.",
					insert = "<Tab>",
				},
				close = {
					normal = "q",
					insert = "<C-c>",
				},
				reset = {
					normal = "<C-l>",
					insert = "<C-l>",
				},
				submit_prompt = {
					normal = "<CR>",
					insert = "<C-s>",
				},
				accept_diff = {
					normal = "<C-y>",
					insert = "<C-y>",
				},
				yank_diff = {
					normal = "gy",
					register = '"',
				},
				show_diff = {
					normal = "gd",
				},
				show_system_prompt = {
					normal = "gp",
				},
				show_user_selection = {
					normal = "gs",
				},
			},
		},
		-- See Commands section for default commands if you want to lazy load on them
	},

	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
			{
				"stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
				opts = {},
			},
			"nvim-telescope/telescope.nvim", -- Optional: For using slash commands
		},
		config = function()
			require("codecompanion").setup({
				strategies = {
					chat = {
						adapter = "copilot",
					},
					inline = {
						adapter = "copilot",
					},
					agent = {
						adapter = "copilot",
					},
				},
			})
		end,
	},
}

require("lazy").setup(plugins)
