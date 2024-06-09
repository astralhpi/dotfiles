local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
parser_config.gotmpl = {
  install_info = {
    url = "https://github.com/ngalaiko/tree-sitter-go-template",
    files = { "src/parser.c" }
  },
  filetype = "gotmpl",
  used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl", "yaml" }
}

local options = {
  ensure_installed = {
    "lua",
    "vim",
    "vimdoc",
    "python",
    "rust",
    "typescript",
    "hcl",
    "terraform",
    "yaml",
    "json",
    "nix",
    "svelte",
    "kotlin",
    "gotmpl",
    "zig"
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = {
    enable = true,
  },
}

return options
