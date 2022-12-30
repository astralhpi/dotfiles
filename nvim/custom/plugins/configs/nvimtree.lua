local present, nvimtree = pcall(require, "nvim-tree")

if not present then
  return
end


require("base46").load_highlight "nvimtree"

local options = {
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
}
-- check for any override
options = require("core.utils").load_override(options, "kyazdani42/nvim-tree.lua")

nvimtree.setup(options)
