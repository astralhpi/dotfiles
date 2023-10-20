local plugins = {
  -- UI
  {
    "folke/which-key.nvim",
    enabled = true,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    lazy = true,
    opts = require("custom.plugins.configs.others").blankline(),
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "custom.plugins.configs.treesitter"
  },
  {
    "kevinhwang91/promise-async",
    module = { "async", "promise" }
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "nvim-treesitter",
    opts = require("custom.plugins.configs.others").ufo(),
    config = function(_, opts)
      require("ufo").setup(opts)
    end
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = require("custom.plugins.configs.nvimtree")
  },
  {
    "ggandor/leap.nvim",
    dependencies = "tpope/vim-repeat",
    keys = {
      {"s"},
      {"S"},
      {"g"}
    },
    config = function ()
      require("leap").add_default_mappings()
    end
  },
  {
    "mg979/vim-visual-multi",
    event = "VimEnter",
  },
  {
    "windwp/nvim-autopairs",
    opts = require("custom.plugins.configs.others").autopairs()
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    module = "telescope._extensions.fzf",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
  },
  {
    "debugloop/telescope-undo.nvim",
    module = "telescope._extensions.undo",
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "telescope-undo.nvim", "telescope-fzf-native.nvim", { "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0", } },
    opts = require("custom.plugins.configs.others").telescope(),
    config = function()
      require("telescope").load_extension("live_grep_args")
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    config = function(_, opts)
      require("symbols-outline").setup(opts)
    end
  },
  {
    "SmiteshP/nvim-navic",
    module = "nvim-navic",
    config = function()
      require("nvim-navic").setup()
    end
  },
  {
  "utilyre/barbecue.nvim",
    dependencies = { "nvim-navic", "nvim-lspconfig", "nvim-web-devicons" },
    opts = require("custom.plugins.configs.barbecue"),
    config = function(_, opts)
      require("barbecue").setup(opts)
    end,
  },
  {
    "ray-x/guihua.lua",
      build = "cd lua/fzy && make",
      module = "guihua",
  },
  {
    "ray-x/sad.nvim",
    commands = { "Sad" },
    config = function()
      require("sad").setup {
        debug = false,
        diff = "delta",
        ls_file = "fd",
      }
    end
  },
  {
    "booperlv/nvim-gomove",
    keys = {
      {"<M-k>"},
      {"<M-j>"},
      {"<M-h>"},
      {"<M-l>"}
    },
    config = function()
      require("gomove").setup {
        map_default = true,
        reindent = true
      }
    end
  },
  -- IDE - Auto Completion
  {
    "hrsh7th/nvim-cmp",
    opts = require("custom.plugins.configs.others").cmp(),
  },
  -- IDE - Diagnostics
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {
      }
    end
  },
  -- IDE - Language Server
  {
    "williamboman/mason.nvim",
    opts = require("custom.plugins.configs.mason")
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {"williamboman/mason.nvim"},
    module = { "mason" },
    config = function ()
      require("mason-lspconfig").setup()
    end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.configs.lspconfig"
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require "custom.plugins.configs.null_ls"
    end,
  },
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

  -- IDE - AI Assistants
  {
    "github/copilot.vim",
    event = "InsertEnter",
  },

  -- IDE - Just
  {
    "NoahTheDuke/vim-just",
    ft = { "just" }
  },

  -- IDE - Diff
  {
    "sindrets/diffview.nvim",
    cmd = {"DiffviewOpen", "DiffviewFileHistory", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewRefresh"},
    config = function()
      require("diffview").setup()
    end
  }
}

return plugins
