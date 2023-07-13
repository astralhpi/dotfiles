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
  local options = {
    provider_selector = function(bufnr, filetype, buftype)
      return {'treesitter', 'indent'}
    end
  }

  return options
end

M.autopairs = function()
  return {
    map_bs = false
  }
end

M.telescope = function()
  return {
    extensions_list = { "themes", "terms", "undo", "fzf" },
  }
end

M.cmp = function()
  return {
    performance = {
      debounce = 120,
      throttle = 60,
    },
    sources = {
      { name = "luasnip" },
      { name = "nvim_lsp" },
      { name = "buffer" },
      { name = "nvim_lua" },
      { name = "path" },
      { name = "cmp_tabnine"}
    },
  }
end

M.cmp_tabnine = function()
  local present, tabnine = pcall(require, "cmp_tabnine.config")

  local options = {
    max_lines = 1000,
    max_num_results = 20,
    sort = true,
  }

  options = load_override(options, "cmp_tabnine")
  tabnine:setup(options)
end

return M
