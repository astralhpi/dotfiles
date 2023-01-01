local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local options = {
  sources = {
    null_ls.builtins.formatting.prettier,
  }
}

options = require("core.utils").load_override(options, "jose-elias-alvarez/null-ls.nvim")
null_ls.setup(options)

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format()
  end,
})
