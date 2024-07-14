---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "catppuccin",
  hl_override = {
    FoldColumn = { bg = "none", fg = "light_grey" },
  },
  hl_add = {
    -- Diagnostic
    DiagnosticUnderlineError = { undercurl = true, sp = "#ff7070" },
    DiagnosticUnderlineWarn = { undercurl = true, sp = "#FFB86C" },
    DiagnosticUnderlineInfo = { undercurl = true, sp = "#a1b1e3" },
    DiagnosticUnderlineHint = { undercurl = true, sp = "#BD93F9" },
    WinBar = { bg = "none" },
    WinBarNC = { bg = "none" },
  },
  nvdash = {
    load_on_startup = true
  },
}

require 'commands'

return M
