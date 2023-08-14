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

local nextBuffer = {
  function()
    require("nvchad.tabufline").tabuflineNext()
  end,
  "goto next buffer",
}

local prevBuffer = {
  function()
    require("nvchad.tabufline").tabuflinePrev()
  end,
  "goto prev buffer",
}


M.tabufline = {
  n = {
    ["<M-}>"] = nextBuffer,
    ["<M-{>"] = prevBuffer,
    ["<M-S-]>"] = nextBuffer,
    ["<M-S-[>"] = prevBuffer,
    ["<M-q>"] = {
      function()
        require("nvchad.tabufline").close_buffer()
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
    ["<leader>tr"] = { "<cmd> Telescope resume<CR>", "telescope resume" },
  }
}

M.symbols_outline = {
  n = {
    ["<M-\\>"] = { "<cmd> SymbolsOutline <CR>", "show symbols outline" },
  }
}

M.lspconfig = {
  n = {
    ["<C-]>"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "lsp definition",
    },
    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "lsp formatting",
    },
    ["[d"] = {
      function()
        vim.diagnostic.goto_prev()
      end,
      "goto prev",
    },

    ["]d"] = {
      function()
        vim.diagnostic.goto_next()
      end,
      "goto_next",
    },
  }
}

M.copilot = {
  i = {
    ["<C-g>"] = { "copilot#Accept('<CR>')", opts = {
        noremap = true,
        expr = true,
        silent = true,
        replace_keycodes = false
      }
    },
  }
}

M.cmp = {
  i = {
    ["<C-n>"] = {
      function()
        require('cmp').complete()
      end,
      "cmp complete",
    }
  }
}

return M
