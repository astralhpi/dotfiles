return {
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
  ["zbirenbaum/copilot.lua"] = {
    event = "InsertEnter",
    config = function ()
      require('custom.plugins.configs.others').copilot()
    end,
  },
  ["kyazdani42/nvim-tree.lua"] = {
    requires = 'nvim-tree/nvim-web-devicons',
    config = function ()
      require('custom.plugins.configs.nvimtree')
    end
  },

  -- IDE - Just
  ["NoahTheDuke/vim-just"] = {
    ft = { "just" }
  }
}
