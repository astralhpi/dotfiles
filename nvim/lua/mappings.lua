require "nvchad.mappings"

local map = vim.keymap.set

-- common mappings
map("n", "<leader>rr", function()
  require("custom/utils").reload_nvim_conf()
end, { desc = "reload config" })


-- tabufline
local nextBuffer = function()
  require("nvchad.tabufline").next()
end

local prevBuffer = function()
  require("nvchad.tabufline").prev()
end

map("n", "<M-}>", nextBuffer, { desc = "goto next buffer" })
map("n", "<M-{>", prevBuffer, { desc = "goto prev buffer" })
map("n", "<M-S-]>", nextBuffer, { desc = "goto next buffer" })
map("n", "<M-S-[>", prevBuffer, { desc = "goto prev buffer" })
map("n", "<M-q>", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "close buffer" })

-- nvim-tree
map("n", "<C-\\>", ":NvimTreeToggle <CR>", { desc = "toggle nvimtree" })
map("n", "<leader>\\", ":NvimTreeFocus <CR>", { desc = "focus nvimtree" })

-- telescope
map("n", "<C-p>", ":Telescope find_files <CR>", { desc = "find files" })
map("n", "<C-t>", ":Telescope buffers <CR>", { desc = "find buffers" })
map("n", "<leader>fk", ":Telescope keymaps <CR>", { desc = "show keys" })
map("n", "<leader>fu", ":Telescope undo <CR>", { desc = "show undo history" })
map("n", "<leader>fs", ":Telescope lsp_document_symbols <CR>", { desc = "show document symbole" })
map("n", "<leader>fS", ":Telescope lsp_workspace_symbols <CR>", { desc = "show workspace symbole" })
map("n", "<leader>tr", ":Telescope resume <CR>", { desc = "telescope resume" })

-- outline
map("n", "<M-\\>", ":Outline <CR>", { desc = "show symbols outline" })

-- lspconfig
map("n", "<C-]>", ":lua vim.lsp.buf.definition() <CR>", { desc = "lsp definition" })
map("n", "<leader>fm", ":lua vim.lsp.buf.format() <CR>", { desc = "lsp formatting" })
map("n", "[d", ":lua vim.diagnostic.goto_prev() <CR>", { desc = "diagnostic prev" })
map("n", "]d", ":lua vim.diagnostic.goto_next() <CR>", { desc = "diagnostic next" })

-- cmp
map("i", "<C-n>", function()
  require("cmp").complete()
end, { desc = "cmp complete" })

-- copliot chat
map("v", "<leader>ae", ":CopilotChatExplain <CR>", { desc = "Copilot Chat Explain" })
map("v", "<leader>ar", ":CopilotChatReview <CR>", { desc = "Copilot Chat Review" })
map("v", "<leader>af", ":CopilotChatFix <CR>", { desc = "Copilot Chat Fix" })
map("v", "<leader>aa", ":CopilotChatFixDiagnostic <CR>", { desc = "Copilot Chat Fix Diagnostic" })
map("v", "<leader>ao", ":CopilotChatOptimize <CR>", { desc = "Copilot Chat Optimize" })
map("v", "<leader>ad", ":CopilotChatDocs <CR>", { desc = "Copilot Chat Docs" })
map("v", "<leader>at", ":CopilotChatTests <CR>", { desc = "Copilot Chat Tests" })
map("n", "<leader>aa", ":CopilotChatFixDiagnostic <CR>", { desc = "Copilot Chat Fix Diagnostic" })
map("n", "<leader>ac", ":CopilotChatCommit <CR>", { desc = "Copilot Chat Commit" })
map("n", "<leader>as", ":CopilotChatCommitStaged <CR>", { desc = "Copilot Chat Commit Staged" })

-- ufo
local openAllFolds = function()
  require("ufo").openAllFolds()
end

local closeAllFolds = function()
  require("ufo").closeAllFolds()
end

map("n", "zR", openAllFolds, { desc = "open all folds" })
map("n", "zM", closeAllFolds, { desc = "close all folds" })

-- dropbar.nvim
local dropbarPick = function()
  require("dropbar.api").pick()
end
map("n", "<leader>q", dropbarPick, { desc = "dropbar pick" })

-- actions-preview.nvim
local actionsPreview = function()
  require("actions-preview").code_actions()
end
map({ "n", "v" }, "<leader>cA", actionsPreview, { desc = "actions preview" })
