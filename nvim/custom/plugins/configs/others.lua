local M = {}

local load_override = require("core.utils").load_override

M.blankline = function()
  return {
    indentLine_enabled = 1,
    show_current_context = true,
    show_current_context_start = false,
    char = "▏",
    context_char = "▎",
  }
end

M.ufo = function()
  local present, ufo  = pcall(require, "ufo")

  if not present then
    return
  end

  local options = {
    provider_selector = function(bufnr, filetype, buftype)
      return {'treesitter', 'indent'}
    end
  }

  options = load_override(options, "kevinhwang91/nvim-ufo")
  ufo.setup(options)
end

M.copilot = function()
  local present, copilot = pcall(require, "copilot")

  if not present then
    return
  end

  local options = {
    panel = {
      enabled = false
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept = "<C-g>",
      }
    },
  }

  options = load_override(options, "zbirenbaum/copilot.lua")
  copilot.setup(options)
end

return M