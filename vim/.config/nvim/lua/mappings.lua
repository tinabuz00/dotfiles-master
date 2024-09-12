local keymap = vim.keymap.set

-- Leader key
vim.g.mapleader = ","
vim.g.maplocalleader = ";"

-- Normal mode mappings
keymap("n", "0", "^")
keymap("n", "^", "0")
keymap("n", "<leader><space>", ":nohlsearch<CR>")
keymap("n", "j", "gj")
keymap("n", "k", "gk")
keymap("n", "gh", "gT")
keymap("n", "gl", "gt")
keymap("n", "H", "<C-o>")
keymap("n", "L", "<C-i>")


-- Window swap
keymap("n", "<leader>sw", ":call WindowSwap#EasyWindowSwap()<CR>")

-- Fold mappings
keymap("n", "<space>", "za")
keymap("n", "<Tab>", "zj")
keymap("n", "<S-Tab>", "zk")
keymap("v", "<Space>", "zf")

-- Other mappings
keymap("n", "<leader>u", ":UndotreeToggle<CR>")
keymap("n", "<leader>f", ":Format<CR>")
keymap("n", "<leader>m", ":ConMenu<CR>")

-- by default ctrl-l auto completes command line
-- I remap it to tab:
keymap("c", "<C-l>", "<Tab>")

vim.keymap.set("n", "gX", [[:exec search("- \\[ \\]", "bcn", line(".")) ? "norm ci]x" : "norm ci] "<CR>]], {})
vim.keymap.set(
	"x",
	"gX",
	[[:<C-U>exec search("- \\[ \\]", "bcn", line("'<")) ? "'<,'>norm ci]x" : "'<,'>norm ci] "<CR>]],
	{}
)



