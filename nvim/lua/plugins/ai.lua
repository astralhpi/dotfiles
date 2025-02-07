-- AI 관련 플러그인
return {
  {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<C-g>",
        }
      })
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "codecompanion" }
      },
      "j-hui/fidget.nvim",
      'echasnovski/mini.diff'
    },
    lazy = false,
    init = function()
      require("configs.codecompanion.fidget-spinner"):init()
    end,
    config = function()
      require("codecompanion").setup({
        display = {
          diff = {
            provider = "mini_diff"
          }
        },
        opts = {
          language = "Korean"
        },
        strategies = {
          chat = {
            adapter = "gemini",
          },
          inline = {
            adapter = "gemini",
          },
          cmd = {
            adapter = "gemini",
          }
        },
        adapters = {
          gemini = function()
            return require("codecompanion.adapters").extend("gemini", {
              env = {
                api_key = "cmd:op read op://Dev/gemini/api-key --no-newline",
              },
              handlers = {
                inline_output = function(self, data, context)
                  if data and data ~= "" then
                    data = data:sub(6)
                    local ok, json = pcall(vim.json.decode, data, { luanil = { object = true } })

                    if not ok then
                      return
                    end

                    local text = json.candidates[1].content.parts[1].text
                    local model = json.modelVersion

                    if model == "gemini-2.0-flash-001" then
                      text = text:gsub("```", "")
                      if context then
                        text = text:gsub(context.filetype .. "\n", "")
                      end
                    end

                    return text
                  end
                end,
              },
              schema = {
                model = {
                  default = "gemini-2.0-flash-001",
                },
                choices = {
                  "gemini-2.0-flash-001",
                  "gemini-2.0-flash-lite-preview-02-05",
                }
              }
            })
          end,
        },
      })
    end
  }
}
