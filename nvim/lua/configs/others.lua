local M = {}

M.ufo = function()
  local options = {
    provider_selector = function(bufnr, filetype, buftype)
      return { 'treesitter', 'indent' }
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
      { name = "cmp_tabnine" }
    },
  }
end
return M
