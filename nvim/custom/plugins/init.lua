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
    config = function()
      require "custom.plugins.configs.treesitter"
    end,
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
  ["nvim-tree/nvim-tree.lua"] = {
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
  ["SmiteshP/nvim-navic"] = {
    module = "nvim-navic",
    config = function()
      require('nvim-navic').setup()
    end
  },
  ["utilyre/barbecue.nvim"] = {
    after = { "nvim-navic", "nvim-lspconfig", "nvim-web-devicons" },
    config = function()
      require('custom.plugins.configs.barbecue')
    end,
  },
  ["ray-x/guihua.lua"] = {
    run = "cd lua/fzy && make",
    module = "guihua",
  },
  ["ray-x/sad.nvim"] = {
    commands = { "Sad" },
    config = function()
      require("sad").setup {
        debug = false,
        diff = "delta",
        ls_file = "fd",
      }
    end
  },

  -- IDE - Auto Completion
  ["hrsh7th/nvim-cmp"] = {
    override_options = require("custom.plugins.configs.others").cmp(),
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
  ["antosha417/nvim-lsp-file-operations"] = {
    requires = {
      "nvim-lua/plenary.nvim",
    },
    after = "nvim-tree.lua",
    config = function()
      require("lsp-file-operations").setup()
    end
  },
  -- IDE - AI Assistants
  ["github/copilot.vim"] = {
    event = "InsertEnter",
  },
  ["tzachar/cmp-tabnine"] = {
    run = "./install.sh",
    after = "nvim-cmp",
    module = { "cmp_tabnine", "cmp_tabnine.compare" },
    config = function()
      require("custom.plugins.configs.others").cmp_tabnine()
    end
  },

  -- IDE - Just
  ["NoahTheDuke/vim-just"] = {
    ft = { "just" }
  }
}
