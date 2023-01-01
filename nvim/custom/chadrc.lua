-- First read our docs (completely) then check the example_config repo

require "custom.options"
local M = {}

M.ui = {
  theme = "chadracula",
  hl_add = {
    DiagnosticUnderlineError = { undercurl = true, sp = "#ff7070" },
    DiagnosticUnderlineWarn = { undercurl = true, sp = "#FFB86C" },
    DiagnosticUnderlineInfo = { undercurl = true, sp = "#a1b1e3" },
    DiagnosticUnderlineHint = { undercurl = true, sp = "#BD93F9" },
  }
}

M.mappings = require "custom.mappings"
M.plugins = require "custom.plugins"

require 'custom.commands'

return M
