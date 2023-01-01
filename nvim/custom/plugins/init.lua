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
  ["nvim-telescope/telescope.nvim"] = {
    requires = {
      "debugloop/telescope-undo.nvim",
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require('plugins.configs.telescope')
      require('custom.plugins.configs.others').telescope()
    end
  },
  ['simrat39/symbols-outline.nvim'] = {
    config = function()
      require('custom.plugins.configs.others').symbols_outline()
    end
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
