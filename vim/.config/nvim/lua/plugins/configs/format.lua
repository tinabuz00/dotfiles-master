local vim = vim

local function expand(args)
	if next(args) == nil then
		return nil
	else
		return unpack(args)
	end
end

-- prettier is used for many languages:
local function prettierFmt(extra_args)
	return function()
		local fname = vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
		return {
			exe = "prettier",
			args = { "--stdin-filepath", fname, expand(extra_args) },
			stdin = true,
		}
	end
end

require("formatter").setup({
	filetype = {
		css = { prettierFmt({}) },
		html = { prettierFmt({}) },
		yaml = { prettierFmt({}) },
		javascript = { prettierFmt({ "--print-width=100" }) },
		javascriptreact = { prettierFmt({ "--print-width=100" }) },
		typescriptreact = { prettierFmt({ "--print-width=100" }) },
		toml = { prettierFmt({}) },
		markdown = { prettierFmt({}) },
		python = {
			function()
				return {
					exe = "ruff",
					args = { "format", "-" },
					stdin = true,
				}
			end,
		},

		--yaml = { -- use yamlfix
		--function()
		--return {
		--exe = "yamlfix",
		--args = { "-" },
		--stdin = true,
		--}
		--end,
		--},

		lua = {
			function()
				return {
					exe = "stylua",
					args = { "--indent-width", 2, "-" },
					stdin = true,
				}
			end,
		},

		cpp = {
			function()
				return {
					exe = "clang-format",
					args = { "--assume-filename", vim.api.nvim_buf_get_name(0) },
					stdin = true,
					cwd = vim.fn.expand("%:p:h"), -- Run clang-format in cwd of the file.
				}
			end,
		},
	},
})
