local global = vim.g
local opts = vim.o

-- leader keys
global.mapleader = " "
global.maplocalleader = " "

-- TAB behaviour
opts.tabstop = 4      -- A TAB character looks like 4 spaces
opts.expandtab = true -- TAB key will insert spaces instead of a TAB character
opts.softtabstop = 4  -- Number of spaces inserted instead of a TAB character
opts.shiftwidth = 4   -- Number of spaces inserted when indenting

-- Lines
opts.number = true
opts.relativenumber = false

-- Behaviour
opts.wrap = false
opts.signcolumn = "yes"
opts.winborder = "rounded"

opts.mouse = 'a'

-- display certain whitespace characters differently
opts.list = true

vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- keep lines above and below
opts.scrolloff = 10

-- Display which-key popup sooner
opts.timeoutlen = 300

opts.swapfile = false

global.have_nerd_font = true
