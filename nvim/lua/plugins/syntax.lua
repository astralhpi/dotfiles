-- syntax와 관련된 플러그인들
return {
  -- treesitter: 구문 분석 플러그인
  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "configs.treesitter"
  },

  -- indent-blankline: 들여쓰기를 시각적으로 표현
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    opts = {
      indent = { char = "▏", highlight = "IblChar" },
      scope = { char = "▎", highlight = "IblScopeChar" },
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "blankline")

      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
      require("ibl").setup(opts)

      dofile(vim.g.base46_cache .. "blankline")
    end,
  },

  -- nvim-ufo: folding을 위한 플러그인
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require("statuscol.builtin")
          require("statuscol").setup({
            relculright = true,
            segments = {
              { text = { builtin.foldfunc },      click = "v:lua.ScFa" },
              { text = { "%s" },                  click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
            },
          })
        end,
      },
    },
    opts = require("configs.others").ufo(),
    event = "VeryLazy",
    config = function(_, opts)
      require("ufo").setup(opts)
    end
  },

  -- nvim-autopairs: 자동 괄호 삽입 플러그인
  {
    "windwp/nvim-autopairs",
    opts = require("configs.others").autopairs()
  },

  -- outline.nvim: 파일의 symbol outline을 보여주는 플러그인
  {
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    config = function()
      require("outline").setup {}
    end,
  },

  -- Comment.nvim: 코멘트 on/off 플러그인
  {
    'numToStr/Comment.nvim',
    opts = {
    },
    lazy = false,
  }
}
