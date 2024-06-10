-- 언어와 무관한 UI 플러그인들
return {
  -- nvim-tree: 파일 탐색기
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = require("configs.nvimtree")
  },
  -- leap.nvim: 빠르게 텍스트 이동하기 위한 플러그인
  {
    "ggandor/leap.nvim",
    dependencies = "tpope/vim-repeat",
    keys = {
      { "s" },
      { "S" },
      { "g" }
    },
    config = function()
      require("leap").add_default_mappings()
    end
  },
  -- multicursors.nvim: 다중 커서 플러그인
  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
      'smoka7/hydra.nvim',
    },
    opts = {},
    cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
    keys = {
      {
        mode = { 'v', 'n' },
        '<Leader>m',
        '<cmd>MCstart<cr>',
        desc = 'Create a selection for selected text or word under the cursor',
      },
    },
  },
  -- telescope: 텍스트 검색 및 파일 탐색을 위한 플러그인
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "telescope-undo.nvim", "telescope-fzf-native.nvim",
      { "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0", } },
    opts = require("configs.others").telescope(),
    config = function()
      require("telescope").load_extension("live_grep_args")
    end,
  },

  -- telescope-fzf-native.nvim: telescope에서 fzf를 사용하기 위한 플러그인
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    module = "telescope._extensions.fzf",
    build =
    "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
  },

  -- telescope-undo.nvim: telescope에서 undo 기록을 검색하기 위한 플러그인
  {
    "debugloop/telescope-undo.nvim",
    module = "telescope._extensions.undo",
  },
  -- smartcolumn.nvim: 컬러 컬럼을 필요할 때만 표시해주는 플러그인
  {
    "m4xshen/smartcolumn.nvim",
    event = "VeryLazy",
    opts = {
      disabled_filetypes = { "help", "text", "markdown", "nvdash" },
    }
  },
  -- nvim-spectre: find & replace 플러그인
  {
    "nvim-pack/nvim-spectre",
    cmd = { "Spectre" },
    dependencies = "nvim-lua/plenary.nvim",
  },
  -- nvim-gomove: 블럭 단위로 이동시키기 위한 플러그인
  {
    "booperlv/nvim-gomove",
    keys = {
      { "<M-k>" },
      { "<M-j>" },
      { "<M-h>" },
      { "<M-l>" }
    },
    config = function()
      require("gomove").setup {
        map_default = true,
        reindent = true
      }
    end
  },
}
