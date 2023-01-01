-- First read our docs (completely) then check the example_config repo

require "custom.options"
local M = {}

M.ui = {
  theme = "chadracula",
}

M.mappings = require "custom.mappings"
M.plugins = require "custom.plugins"

require 'custom.commands'

return M
