vim.api.nvim_create_user_command(
  "Rg",
  function(opts)
    require("telescope").extensions.live_grep_args.live_grep_args({ default_text = opts.args })
  end,
  { nargs = '?' }
)

vim.api.nvim_create_user_command(
  "Sg",
  function(opts)
    require("telescope").extensions.ast_grep.ast_grep({ default_text = opts.args })
  end,
  { nargs = '?' }
)
