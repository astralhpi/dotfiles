-- AI 관련 플러그인
return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
          debounce = 50,
          keymap = {
            accept = "<C-g>"
          }
        }
      })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
    },
    cmd = { "CopilotChat" },
    event = "VeryLazy",
    config = function()
      local opts = require("configs.copilot_chat")
      require('CopilotChat').setup(opts)
    end
  },

}
