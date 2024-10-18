local vim = vim

vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_filetypes = {
	yaml = true,
}

vim.api.nvim_set_keymap("i", "<C-Space>", "copilot#Accept('<CR>')", { silent = true, expr = true })

local set_hl = vim.api.nvim_set_hl

local rgb_to_hex = function(rgb)
	return string.format("#%02x%02x%02x", rgb[1], rgb[2], rgb[3])
end
local bit = require("bit")

local function get_fg_color(hlgroup)
	local hl = vim.api.nvim_get_hl(0, { name = hlgroup, link = false })
	local fg = hl.fg
	if fg then
		return rgb_to_hex({
			bit.rshift(bit.band(fg, 0xFF0000), 16),
			bit.rshift(bit.band(fg, 0x00FF00), 8),
			bit.band(fg, 0x0000FF),
		})
	end
	return nil
end

local function get_bg_color(hlgroup)
	local hl = vim.api.nvim_get_hl(0, { name = hlgroup, link = false })
	local bg = hl.bg
	if bg then
		return rgb_to_hex({
			bit.rshift(bit.band(bg, 0xFF0000), 16),
			bit.rshift(bit.band(bg, 0x00FF00), 8),
			bit.band(bg, 0x0000FF),
		})
	end
	return nil
end


local function setup_avante_highlights()
	-- Apply highlights for title
	set_hl(0, "AvanteTitle", { link = "lualine_a_command" })
	set_hl(0, "AvanteReversedTitle", {
		bg = get_bg_color("Normal"),
		fg = get_bg_color("lualine_a_command"),
	})
	-- Apply highlights for subtitle
	set_hl(0, "AvanteSubtitle", { link = "lualine_a_replace" })
	set_hl(0, "AvanteReversedSubtitle", {
		bg = get_bg_color("Normal"),
		fg = get_bg_color("lualine_a_replace"),
	})
	-- Apply highlights for prompt
	set_hl(0, "AvanteThirdTitle", { link = "lualine_a_insert" })
	set_hl(0, "AvanteReversedThirdTitle", {
		bg = get_bg_color("Normal"),
		fg = get_bg_color("lualine_a_insert"),
	})
	-- Apply highlights for hints
	set_hl(0, "AvanteInlineHint", { link = "LspDiagnosticsVirtualTextHint" })
	set_hl(0, "AvantePopupHint", { link = "DiagnosticVirtualTextHint" })
end


setup_avante_highlights()

return {
	{
		"github/copilot.vim",
		event = "InsertEnter",
		config = function()
			require("plugins.configs.copilot")
			vim.cmd("Copilot")
		end,
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false, -- set this if you want to always pull the latest change
		opts = {
			-- add any opts here
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			{
				-- Make sure to set this up properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
		config = function()
			require("avante").setup({
				---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
				provider = "copilot",
				auto_suggestions_provider = "copilot",
				behaviour = {
					auto_suggestions = false, -- Experimental stage
					auto_set_highlight_group = true,
					auto_set_keymaps = true,
					auto_apply_diff_after_generation = false,
					support_paste_from_clipboard = false,
				},
				mappings = {
					--- @class AvanteConflictMappings
					diff = {
						ours = "co",
						theirs = "ct",
						all_theirs = "ca",
						both = "cb",
						cursor = "cc",
						next = "]x",
						prev = "[x",
					},
					suggestion = {
						accept = "<M-l>",
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
					jump = {
						next = "]]",
						prev = "[[",
					},
					submit = {
						normal = "<CR>",
						insert = "<C-s>",
					},
					ask = "<leader>aa",
					edit = "<leader>ae",
					refresh = "<leader>ar",
					toggle = {
						default = "<leader>at",
						debug = "<leader>ad",
						hint = "<leader>ah",
						suggestion = "<leader>as",
					},
					sidebar = {
						switch_windows = "<Tab>",
						reverse_switch_windows = "<S-Tab>",
					},
				},

				hints = { enabled = true },
				windows = {
					---@type "right" | "left" | "top" | "bottom"
					position = "right", -- the position of the sidebar
					wrap = true, -- similar to vim.o.wrap
					width = 30, -- default % based on available width
					sidebar_header = {
						align = "center", -- left, center, right for title
						rounded = true,
					},
				},
			})
		end,
	},
}
