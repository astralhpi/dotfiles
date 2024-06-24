-- 언어 지원
return {
  {
    "NoahTheDuke/vim-just",
    ft = { "just" }
  },
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim',   -- optional for vim.ui.select
    },
    config = true,
  }
}
