local M = {}

M.general = {
}

M.custom = {
  n = {
    ["<leader>rr"] = {
      function()
        require("custom/utils").reload_nvim_conf()
      end,
      "reload config"
    }
  }
}

M.tabufline = {
  n = {
    ["<M-}>"] = {
      function()
        require("nvchad_ui.tabufline").tabuflineNext()
      end,
      "goto next buffer",
    },
    ["<M-{>"] = {
      function()
        require("nvchad_ui.tabufline").tabuflinePrev()
      end,
      "goto prev buffer",
    },
    ["<M-q>"] = {
      function()
        require("nvchad_ui.tabufline").close_buffer()
      end,
      "close buffer",
    }
  }
}

M.nvimtree = {
  n = {
    ["<C-\\>"]  = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
    ["<leader>\\"] = { "<cmd> NvimTreeFocus <CR>", "focus nvimtree" },
  }
}

M.telescope = {
  n = {
    ["<C-p>"] = { "<cmd> Telescope find_files <CR>", "find files" },
    ["<C-t>"] = { "<cmd> Telescope buffers <CR>", "find buffers" },
    ["<leader>fk"] = { "<cmd> Telescope keymaps <CR>", "show keys" },
    ["<leader>fu"] = { "<cmd> Telescope undo <CR>", "show undo history" },
    ["<leader>fs"] = { "<cmd> Telescope lsp_document_symbols<CR>", "show document symbole" },
    ["<leader>fS"] = { "<cmd> Telescope lsp_workspace_symbols<CR>", "show workspace symbole" },
  }
}

M.symbols_outline = {
  n = {
    ["<M-\\>"] = { "<cmd> SymbolsOutline <CR>", "show symbols outline" },
  }
}

return M
