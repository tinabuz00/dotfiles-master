vim.loader.enable()

require "options"
require "mappings"
require "commands"

-- bootstrap plugins & lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim" -- path where its going to be installed

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)
require "plugins"
require "misc"

vim.cmd.set("background=dark")
--vim.cmd.colorscheme("ayu")
vim.cmd.colorscheme("tokyonight-night")
--vim.cmd.colorscheme("monokai-pro-spectrum")
--vim.cmd("hi Normal guibg=#151515")

vim.cmd([[hi @multilinestring guifg=#aabbba]])

vim.cmd([[hi link VisualNonText Visual]])
vim.cmd([[hi VisualNonText guibg=#283450 guifg=#505480]])
--vim.cmd([[hi Visual guibg=#444444]])


