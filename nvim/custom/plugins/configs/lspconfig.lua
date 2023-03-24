local _on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local navic = require("nvim-navic")

local lspconfig = require "lspconfig"
local servers = {
  -- node
  "tsserver",

  -- rust
  "rust_analyzer",

  -- python
  "pyright",

  -- terraform
  "terraformls",

  -- nix
  "nil_ls",

  -- svelte
  "svelte",

  -- kotlin
  "kotlin_language_server",
}

capabilities.workspace.fileOperations = {
  willRename = true,
}

function on_attach(client, bufnr)
  _on_attach(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    print("documentSymbolProvider")
    navic.attach(client, bufnr)
  end
end

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150
    }
  }
end
