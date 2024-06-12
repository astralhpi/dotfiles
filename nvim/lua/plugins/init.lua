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

  -- Test
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "marilari88/neotest-vitest",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-vitest")
        }
      })
    end
  }
}
