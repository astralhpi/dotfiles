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
    cmd = { "ToggleBlame", "EnableBlame" }
  },
}
