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
  ["kevinhwang91/nvim-ufo"] = {
    requires = 'kevinhwang91/promise-async',
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
    config = function ()
      require('leap').add_default_mappings()
    end
  },
  ["mg979/vim-visual-multi"] = {
  },
  ["windwp/nvim-autopairs"] = {
    after = "nvim-cmp",
    override_options = require("custom.plugins.configs.others").autopairs()
  },
  ["nvim-telescope/telescope-fzf-native.nvim"] = {
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  },
  ["nvim-telescope/telescope.nvim"] = {
    requires = {
      "debugloop/telescope-undo.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    override_options = require("custom.plugins.configs.others").telescope(),
  },
  ['simrat39/symbols-outline.nvim'] = {
    config = function()
      require('custom.plugins.configs.others').symbols_outline()
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
