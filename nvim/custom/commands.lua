vim.api.nvim_create_user_command(
  "Rg",
  function(opts)
    require("telescope.builtin").live_grep({ default_text=opts.args })
  end,
  { nargs = 1}
)
