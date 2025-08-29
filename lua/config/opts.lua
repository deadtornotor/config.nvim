--- ===================================================
--- Settings
--- ===================================================

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basics
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.wrap = false

-- Indentation
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.scrolloff = 10
vim.o.sidescrolloff = 8

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false
vim.o.incsearch = true

-- Visual
vim.o.termguicolors = true
vim.o.signcolumn = "yes"
vim.o.showmode = false
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.g.have_nerd_font = true

-- Files
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.undofile = true
vim.o.updatetime = 300
vim.o.timeoutlen = 300
vim.o.ttimeoutlen = 0
vim.o.autoread = true
vim.o.autowrite = false

-- Behaviour
vim.o.hidden = true
vim.o.mouse = 'a'
vim.o.encoding = 'UTF-8'
vim.o.timeoutlen = 300

vim.cmd.colorscheme("habamax")
vim.cmd("set completeopt+=noselect")
