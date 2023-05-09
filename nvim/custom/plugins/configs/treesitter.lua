local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not present then
  return
end

local parser_config = require'nvim-treesitter.parsers'.get_parser_configs()
parser_config.gotmpl = {
  install_info = {
    url = "https://github.com/ngalaiko/tree-sitter-go-template",
    files = {"src/parser.c"}
  },
  filetype = "gotmpl",
  used_by = {"gohtmltmpl", "gotexttmpl", "gotmpl", "yaml"}
}

require("base46").load_highlight "treesitter"

local options = {
  ensure_installed = {
    "lua",
    "vim",
    "python",
    "rust",
    "typescript",
    "hcl",
    "terraform",
    "help",
    "yaml",
    "json",
    "nix",
    "svelte",
    "kotlin",
    "gotmpl"
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = {
    enable = true,
  },
}

-- check for any override
options = require("core.utils").load_override(options, "nvim-treesitter/nvim-treesitter")

treesitter.setup(options)
