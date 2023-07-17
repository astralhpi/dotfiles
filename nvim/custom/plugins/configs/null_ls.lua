local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end


local options = {
  sources = {
    -- node
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.code_actions.eslint_d,

    -- python
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.ruff,
    null_ls.builtins.diagnostics.ruff,

    -- rust
    null_ls.builtins.formatting.rustfmt,

    -- terraform
    null_ls.builtins.formatting.terraform_fmt,

    -- kotlin
    null_ls.builtins.formatting.ktlint,
    null_ls.builtins.diagnostics.ktlint,
  }
}

null_ls.setup(options)
null_ls.register({
  name = "svelte",
  filetypes = { "svelte" },
  sources = { null_ls.builtins.formatting.prettier }
})

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format()
  end,
})
