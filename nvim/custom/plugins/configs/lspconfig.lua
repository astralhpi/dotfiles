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

  "emmet_ls"
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
  if lsp == "svelte" then
    lspconfig.svelte.setup {
      on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePost", {
          pattern = { "*.js", "*.ts" },
          callback = function(ctx)
            client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
          end,
        })
        on_attach(client, bufnr)
      end,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150
      }
    }
  elseif lsp == "emmet_ls" then
    lspconfig.emmet_ls.setup {
    -- on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug", "typescriptreact", "vue", "jsx" },
      init_options = {
        html = {
          options = {
            -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
            ["bem.enabled"] = true,
          },
        },
      }
    }
  else
    lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150
      }
    }
  end
end
