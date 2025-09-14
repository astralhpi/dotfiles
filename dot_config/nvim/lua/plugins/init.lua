return {
  -- IDE - Auto Completion
  {
    "hrsh7th/nvim-cmp",
    opts = require("configs.others").cmp(),
  },
  -- IDE - Diff
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewRefresh" },
    config = function()
      require("diffview").setup()
    end
  },

  --- IDE - Git
  {
    "FabijanZulj/blame.nvim",
    cmd = { "BlameToggle" },
    config = function()
      require("blame").setup()
    end
  },

  {
    "NeogitOrg/neogit",
    cmd = { "Neogit" },
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua",              -- optional
    },
    config = true
  },

  -- Test
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "marilari88/neotest-vitest",
      "jfpedroza/neotest-elixir",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-vitest"),
          require("neotest-elixir")
        }
      })
    end
  },
  -- DB IDE
  {
    "kndndrj/nvim-dbee",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    cmd = { "Dbee" },
    build = function()
      -- Install tries to automatically detect the install method.
      -- if it fails, try calling it with one of these parameters:
      --    "curl", "wget", "bitsadmin", "go"
      require("dbee").install()
    end,
    config = function()
      require("dbee").setup( --[[optional config]])
    end,
  },

  -- catppuccin
  {
    "catppuccin/nvim",
    priority = 1000,
    event = "VeryLazy",
    config = function()
      require("catppuccin").setup({
        flavour = 'macchiato', -- latte, frappe, macchiato, mocha
        transparent_background = true
      })
      vim.cmd.colorscheme "catppuccin-macchiato"
    end,
  },

  -- image preview 
  {
    "3rd/image.nvim",
    event = "VeryLazy",
    config = function()
      require("image").setup({
        backend = "kitty",
        processor = "magick_cli"
      })
    end,
  },
  {
    'echasnovski/mini.diff',
    config = function()
      require('mini.diff').setup()
    end
  },
}
