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
    ["<C-\\>"]     = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
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
M.copilot_chat = {
  v = {
    ["<leader>ae"] = {"<cmd>CopilotChatExplain<cr>", "Copilot Chat Explain"},
    ["<leader>ar"] = {"<cmd>CopilotChatReview<cr>", "Copilot Chat Review"},
    ["<leader>af"] = {"<cmd>CopilotChatFix<cr>", "Copilot Chat Fix"},
    ["<leader>aa"] = {"<cmd>CopilotChatFixDiagnostic<cr>", "Copilot Chat Fix Diagnostic"},
    ["<leader>ao"] = {"<cmd>CopilotChatOptimize<cr>", "Copilot Chat Optimize"},
    ["<leader>ad"] = {"<cmd>CopilotChatDocs<cr>", "Copilot Chat Docs"},
    ["<leader>at"] = {"<cmd>CopilotChatTests<cr>", "Copilot Chat Tests"},
  },
  n = {
    ["<leader>aa"] = {"<cmd>CopilotChatFixDiagnostic<cr>", "Copilot Chat Fix Diagnostic"},
    ["<leader>ac"] = {"<cmd>CopilotChatCommit<cr>", "Copilot Chat Commit"},
    ["<leader>as"] = {"<cmd>CopilotChatCommitStaged<cr>", "Copilot Chat Commit Staged"},
  }

}

return M
