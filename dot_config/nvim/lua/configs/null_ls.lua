local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end


local options = {
  sources = {
    -- node
    null_ls.builtins.formatting.prettierd,
    require("none-ls.diagnostics.eslint_d"),

    -- python
    require("none-ls.formatting.ruff"),
    require("none-ls.diagnostics.ruff"),

    -- rust
    require("none-ls.formatting.rustfmt"),

    -- terraform
    null_ls.builtins.formatting.terraform_fmt,

    -- kotlin
    null_ls.builtins.formatting.ktlint,
    null_ls.builtins.diagnostics.ktlint,
  }
}

null_ls.setup(options)

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format()
  end,
})
