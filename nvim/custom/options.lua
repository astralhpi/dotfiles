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
opt.foldmethod = "expr"
opt.foldlevel = 99
opt.foldcolumn = '0'
-- TODO: fold column을 예쁘게 만들기 위해서 
-- 1. neovim에 https://github.com/neovim/neovim/pull/17446 머지된 이후,
-- 2. https://github.com/kevinhwang91/nvim-ufo/issues/4 참고해서 수정해야함.

-- etc
opt.visualbell = true

-- plugin
g.copilot_no_tab_map = true

