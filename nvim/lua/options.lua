require "nvchad.options"

local opt = vim.opt
local g = vim.g

-- cursor
opt.whichwrap = ""

-- file
opt.swapfile = false
opt.backup = true
opt.backupdir = { ".backup/vim" }

opt.autoread = true

-- width
opt.colorcolumn = "88"

-- fold
opt.foldlevelstart = 99
opt.foldlevel = 99
opt.foldcolumn = '1'
opt.foldenable = true
opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- etc
opt.visualbell = true

-- plugin
g.copilot_no_tab_map = true

-- color
opt.termguicolors = true
