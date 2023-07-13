-- First read our docs (completely) then check the example_config repo

local M = {}

M.ui = {
  theme = "chadracula",
  hl_add = {
    -- Diagnostic
    DiagnosticUnderlineError = { undercurl = true, sp = "#ff7070" },
    DiagnosticUnderlineWarn = { undercurl = true, sp = "#FFB86C" },
    DiagnosticUnderlineInfo = { undercurl = true, sp = "#a1b1e3" },
    DiagnosticUnderlineHint = { undercurl = true, sp = "#BD93F9" },
  },
  nvdash = {
    load_on_startup = true
  }
}

M.mappings = require "custom.mappings"
M.plugins = "custom.plugins"

require 'custom.commands'

return M
