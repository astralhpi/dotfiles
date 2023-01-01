return {
  -- UI
  ["goolord/alpha-nvim"] = {
    disable = false,
    override_options = require("custom.plugins.configs.alpha")
  },
  ["folke/which-key.nvim"] = {
    disable = false,
  },
  ["lukas-reineke/indent-blankline.nvim"] = {
    opt = true,
    override_options = require("custom.plugins.configs.others").blankline(),
  },
  ["nvim-treesitter/nvim-treesitter"] = {
    override_options = require("custom.plugins.configs.treesitter"),
  },
  ['kevinhwang91/promise-async'] = {
    module = { "async", "promise" }
  },
  ["kevinhwang91/nvim-ufo"] = {
    after = "nvim-treesitter",
    config = function ()
      require('custom.plugins.configs.others').ufo()
    end
  },
  ["kyazdani42/nvim-tree.lua"] = {
    requires = 'nvim-tree/nvim-web-devicons',
    config = function ()
      require('custom.plugins.configs.nvimtree')
    end
  },
  ["ggandor/leap.nvim"] = {
    requires = 'tpope/vim-repeat',
    keys = { "s", "S", "g" },
    config = function ()
      require('leap').add_default_mappings()
    end
  },
  ["mg979/vim-visual-multi"] = {
    event = "VimEnter",
  },
  ["windwp/nvim-autopairs"] = {
    override_options = require("custom.plugins.configs.others").autopairs()
  },
  ["nvim-telescope/telescope-fzf-native.nvim"] = {
    module = "telescope._extensions.fzf",
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  },
  ["debugloop/telescope-undo.nvim"] = {
    module = "telescope._extensions.undo",
  },
  ["nvim-telescope/telescope.nvim"] = {
    after = { "telescope-undo.nvim", "telescope-fzf-native.nvim" },
    override_options = require("custom.plugins.configs.others").telescope(),
  },
  ['simrat39/symbols-outline.nvim'] = {
    cmd = "SymbolsOutline",
    config = function()
      require('custom.plugins.configs.others').symbols_outline()
    end
  },
  -- IDE - Diagnostics
  ["folke/trouble.nvim"] = {
    cmd = { "TroubleToggle", "Trouble" },
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
      }
    end
  },
  ["folke/lsp-colors.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require("lsp-colors").setup {}
    end
  },
  -- IDE - Language Server
  ["williamboman/mason.nvim"] = {
    override_options = require("custom.plugins.configs.mason")
  },
  ["williamboman/mason-lspconfig.nvim"] = {
    requires = {"williamboman/mason.nvim"},
    module = { "mason" },
    config = function ()
      require('mason-lspconfig').setup()
    end
  },
  ["neovim/nvim-lspconfig"] = {
    requires = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.configs.lspconfig"
    end,
  },
  ["jose-elias-alvarez/null-ls.nvim"] = {
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open "null-ls.nvim"
    end,
    config = function()
      require "custom.plugins.configs.null_ls"
    end,
  },
  -- IDE - AI Assistants
  ["zbirenbaum/copilot.lua"] = {
    event = "InsertEnter",
    config = function ()
      require('custom.plugins.configs.others').copilot()
    end,
  },

  -- IDE - Just
  ["NoahTheDuke/vim-just"] = {
    ft = { "just" }
  }
}
