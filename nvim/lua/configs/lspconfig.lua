local capabilities = require("nvchad.configs.lspconfig").capabilities
local util = require "lspconfig/util"

local lspconfig = require "lspconfig"
local servers = {
  -- node
  "ts_ls",

  -- deno
  "denols",

  -- rust
  "rust_analyzer",

  -- python
  "pyright",
  "ruff",

  -- terraform
  "terraformls",

  -- nix
  "nil_ls",

  -- svelte
  "svelte",

  -- kotlin
  "kotlin_language_server",

  -- elixir
  "elixirls",

  "emmet_ls"
}

capabilities.workspace.fileOperations = {
  willRename = true,
}

local map = vim.keymap.set
local conf = require("nvconfig").ui.lsp
local on_attach = function(client, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
  map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")

  map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")

  map("n", "<leader>ra", function()
    require "nvchad.lsp.renamer" ()
  end, opts "NvRenamer")

  map("n", "gr", vim.lsp.buf.references, opts "Show references")
end

for _, lsp in ipairs(servers) do
  if lsp == "svelte" then
    lspconfig.svelte.setup {
      on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePost", {
          pattern = { "*.js", "*.ts" },
          group = vim.api.nvim_create_augroup("svelte_ondidchangetsorjsfile", { clear = true }),
          callback = function(ctx)
            client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
          end,
        })
        on_attach(client, bufnr)
      end,
      root_dir = util.root_pattern("package.json"),
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150
      }
    }
  elseif lsp == "emmet_ls" then
    lspconfig.emmet_ls.setup {
      -- on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug",
        "typescriptreact", "vue", "jsx" },
      init_options = {
        html = {
          options = {
            -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
            ["bem.enabled"] = true,
          },
        },
      }
    }
  elseif lsp == "ts_ls" then
    lspconfig.ts_ls.setup {
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        on_attach(client, bufnr)
      end,
      capabilities = capabilities,
      root_dir = util.root_pattern("package.json"),
      single_file_support = false,
      flags = {
        debounce_text_changes = 150
      }

    }
  elseif lsp == 'denols' then
    lspconfig.denols.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = util.root_pattern("deno.json", "deno.jsonc"),
      flags = {
        debounce_text_changes = 150
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
