-- lsp 관련 플러그인들. 대부분 treesitter와 함께 사용됨.
return {
  -- LSP 설정
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  -- winbar에 심볼 경로 표시
  {
    'Bekaboo/dropbar.nvim',
    event = "VeryLazy",
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim'
    }
  },

  -- lsp 설치 도구
  {
    "williamboman/mason.nvim",
    opts = require("configs.mason")
  },

  -- lsp 설정 도구
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    module = { "mason" },
    config = function()
      require("mason-lspconfig").setup()
    end
  },

  -- 추가 lsp 설정용
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      require "configs.null_ls"
    end,
  },

  -- 파일 오퍼레이션을 LSP로 처리 (rename, create, delete)
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree.lua"
    },
    config = function()
      require("lsp-file-operations").setup()
    end
  },

  -- diagnostic 뷰어
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {
      }
    end
  },

  -- code actions 미리보기
  {
    "aznhe21/actions-preview.nvim",
    event = "LspAttach",
    config = function()
      require("actions-preview").setup {}
    end
  }

}
