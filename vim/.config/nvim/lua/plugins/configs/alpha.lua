return {
	{ "nvimdev/dashboard-nvim", enabled = false },
	{ "echasnovski/mini.starter", enabled = false },
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		enabled = true,
		init = false,
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			-- get version (:version)
			local nvim_version = vim.version()
			local logo = {
				[[                                       ]],
				[[                                       ]],
				[[                                       ]],
				[[                         _             ]],
				[[                        (_)            ]],
				[[   _ __   ___  _____   _____ __ ___    ]],
				[[  | '_ \ / _ \/ _ \ \ / / | '_ ` _ \   ]],
				[[  | | | |  __/ (_) \ V /| | | | | | |  ]],
				"  |_| |_|\\___|\\___/ \\_/ |_|_| |_| |_|  "
					.. nvim_version[1]
					.. "."
					.. nvim_version[2]
					.. "."
					.. nvim_version[3],
			}

			dashboard.section.header.val = logo
			dashboard.section.buttons.val = {
				dashboard.button("ff", " " .. " Find file", "<cmd>Telescope pathogen find_files<CR>"),
				dashboard.button("fg", " " .. " Find text", "<cmd>Telescope pathogen live_grep<CR>"),
				dashboard.button("-", " " .. " Open parent directory", "<CMD>Oil<CR>"),
				dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
				dashboard.button("s", " " .. " Last Session", [[:lua require("persistence").load({ last = true }) <cr>]]),
				dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
				dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
				dashboard.button("q", " " .. " Quit", ":qa<CR>"),
			}
			dashboard.section.footer.val = ""

			return dashboard
		end,
		config = function(_, dashboard)
			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "AlphaReady",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			require("alpha").setup(dashboard.opts)
		end,
	},
}
