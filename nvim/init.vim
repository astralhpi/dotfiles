" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

" General Settings 
"
if &compatible
  set nocompatible               " Be iMproved
endif

filetype plugin indent on
syntax on

set ttyfast
set lazyredraw
set termguicolors

set noswapfile
set inccommand=split

set expandtab

set number
set ruler
set nowrap
set textwidth=0
set colorcolumn=88
set visualbell

set ts=4
set sw=4

set hidden
set autoread
set previewheight=5

set clipboard+=unnamed

set mouse=a

set enc=utf-8
set fillchars=""

" fold
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=99

" Better display for messages
set cmdheight=1
set laststatus=2
set showtabline=2
set noshowmode

" Always show signcolumns
set signcolumn=yes

set undofile
set undodir=~/.vim/undo

" Conceal
set conceallevel=0

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'nvim-lua/plenary.nvim'
Plug 'will133/vim-dirdiff'
Plug 'junegunn/goyo.vim'

" Plugins - Buffer
Plug 'qpkorr/vim-bufkill'
Plug 'phaazon/hop.nvim'

" Plugins - Navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-tree/nvim-tree.lua'

" Plugins - UI
Plug 'edkolev/tmuxline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Shougo/denite.nvim'
Plug 'Shougo/echodoc.vim'
Plug 'kyazdani42/nvim-web-devicons'

" Plugins - Text
Plug 'mg979/vim-visual-multi'
Plug 'lukas-reineke/indent-blankline.nvim'

Plug 'simnalamburt/vim-mundo' " Undo Tree

" Plugins - IDE
" IDE - Common 
Plug 'jiangmiao/auto-pairs'
Plug 'elzr/vim-json'
"Plug 'liuchengxu/vista.vim' " For symbol tree
Plug 'tpope/vim-fugitive' " Git commands
Plug 'lewis6991/gitsigns.nvim'
"Plug 'airblade/vim-gitgutter'
Plug 'tyru/caw.vim' " Comment
Plug 'Shougo/context_filetype.vim' " Change file type by context
Plug 'janko-m/vim-test' " Test Commands
Plug 'TimUntersberger/neogit'

" IDE - Debugger
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-dap-python'
Plug 'rcarriga/nvim-dap-ui'

" IDE - LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

" IDE - Auto Complete
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
Plug 'onsails/lspkind-nvim'
Plug 'github/copilot.vim'

" IDE - Just
Plug 'NoahTheDuke/vim-just'
Plug 'IndianBoy42/tree-sitter-just'


" IDE - Treesitter
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'


" IDE - Jenkinsfile
Plug 'martinda/Jenkinsfile-vim-syntax'

" IDE - Dart
Plug 'dart-lang/dart-vim-plugin'

" IDE - Python
"Plug 'manicmaniac/coconut.vim'

" IDE - Swift
Plug 'keith/swift.vim'

" IDE - Kotln
Plug 'udalov/kotlin-vim'

" IDE - Web
Plug 'digitaltoad/vim-pug'
Plug 'posva/vim-vue'
Plug 'cakebaker/scss-syntax.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mattn/emmet-vim'
Plug 'dNitro/vim-pug-complete', { 'for': ['jade', 'pug'] }

" IDE - elixir
Plug 'elixir-lang/vim-elixir'

" IDE - Solidity
Plug 'tomlion/vim-solidity'

" IDE - Rust
Plug 'rust-lang/rust.vim'

" IDE - Python
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }

" IDE - helm
Plug 'towolf/vim-helm'

" IDE - Typescript
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'

" IDE - Terraform
Plug 'hashivim/vim-terraform'

call plug#end()


" Theme
packadd! dracula_pro
let g:dracula_colorterm = 0
colorscheme dracula_pro

set background=dark
autocmd BufEnter * if &previewwindow | setlocal nobuflisted | endif

let g:indentLine_color_term = 59
let g:indentLine_color_gui='#393650'

hi ColorColumn ctermbg=59 guibg=#393650

hi Statement ctermfg=218 guifg=#FF80BF cterm=bold gui=bold

function! MyHighlights()
    hi! link semshiLocal           DraculaFg
    hi! link semshiGlobal          DraculaFgBold
    hi! link semshiImported        DraculaOrangeBold
    hi! link semshiParameter       DraculaCyan
    hi! link semshiParameterUnused DraculaCyanItalic
    hi! link semshiFree            DraculaPink
    hi! link semshiBuiltin         DraculaPurple
    hi! link semshiAttribute       DraculaFg
    hi! link semshiSelf            DraculaPurpleBold
    hi! link semshiUnresolved      DraculaWarnLine
    hi! link semshiSelected        DraculaBgLighter

    hi! link semshiErrorSign       DraculaErrorLine
    hi! link semshiErrorChar       DraculaErrorLine
    sign define semshiError text=E> texthl=semshiErrorSign
endfunction
autocmd FileType python call MyHighlights()
autocmd ColorScheme * call MyHighlights()

" Semshi
let g:semshi#error_sign = v:false


" 기본 키 설정
if has("gui_running")
    " C-Space seems to work under gVim on both Linux and win32
    inoremap <C-Space> <C-n>
else " no gui
  if has("unix")
    inoremap <Nul> <C-n>
  else
  " I have no idea of the name of Ctrl-Space elsewhere
  endif
endif

nmap ’ :bnext<CR>
nmap <M-}> :bnext<CR>
nmap ” :bprevious<CR>
nmap <M-{> :bprevious<CR>
nmap † :enew<CR>
nmap <M-t> :enew<CR>
nmap œ :BD<CR>
nmap <M-q> :BD<CR>
nmap » :Vista!!<CR>
nmap <M-\> :Vista!!<CR>


nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" 플러그인 설정
" fzf
map <C-p> :Files<CR>
map <C-t> :Buffers<CR>
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--preview', 'bat --style=numbers --color=always --line-range :200 {}']}, <bang>0)
map <M-w> :Windows<CR>

" NERDTree
let g:NERDTreeNodeDelimiter = "\u00a0"
nmap <C-\> :NvimTreeToggle<CR>

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

"indentLine
let g:indentLine_char= '▏'
" auto-pairs
let g:AutoPairsMultilineClose = 0


" " caw
map <leader>/ <Plug>(caw:hatpos:toggle)

" Run jest for current project
command! -nargs=0 Jest :call  CocAction('runCommand', 'jest.projectTest')

" Run jest for current file
command! -nargs=0 JestCurrent :call  CocAction('runCommand', 'jest.fileTest', ['%'])

let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'

highlight link EchoDocFloat Pmenu

" visual-multi
let g:VM_maps = {}
let g:VM_maps['Add Cursor Up']  = '<M-Up>'
let g:VM_maps['Add Cursor Down']  = '<M-Down>'

au BufWritePre *.py,*.ts,*.js,*.svelte,*.rs lua vim.lsp.buf.formatting_sync()

" debugger
nnoremap <silent> ® :lua require'dap'.continue()<CR>
nnoremap <silent> ˜ :lua require'dap'.step_over()<CR>
nnoremap <silent> ˆ :lua require'dap'.step_into()<CR>
nnoremap <silent> ø :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>
nnoremap <silent> <leader>dt :lua require("dapui").toggle()<CR>

" copilot
let g:copilot_no_tab_map = v:true
imap <expr> <Plug>(vimrc:copilot-dummy-map) copilot#Accept("\<Tab>")

lua <<EOF
vim.o.updatetime = 250
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    incremental_selection = {
        enabled = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
    },
    indent = {
        enable = true
    },
    additional_vim_regex_highlighting = true
  },
}
require'nvim-treesitter.configs'.setup {
  textobjects = {
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
}

local neogit = require('neogit')
neogit.setup {}

-- hop
vim.api.nvim_set_keymap('n', '\\w', "<cmd>lua require'hop'.hint_words()<cr>", {})
vim.api.nvim_set_keymap('n', '\\l', "<cmd>lua require'hop'.hint_lines()<cr>", {})
vim.api.nvim_set_keymap('n', '\\/', "<cmd>lua require'hop'.hint_patterns()<cr>", {})

-- gitsign
require('gitsigns').setup()

-- nvim-dap
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
require('dap-python').test_runner = 'pytest'
require("dapui").setup()
EOF


set completeopt=menu,menuone,noselect
lua <<EOF
    local tabnine = require('cmp_tabnine.config')
    tabnine:setup({
            max_lines = 1000;
            max_num_results = 20;
            sort = true;
        run_on_every_keystroke = true;
        snippet_placeholder = '..';
    })

    local lspkind = require('lspkind')

    -- Setup nvim-cmp.
    local cmp = require'cmp'

    cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
          end,
        },
        mapping = {
            ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
            ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
            ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
            ['<CR>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            }),
            ['<C-g>'] = cmp.mapping(function(fallback)
                vim.api.nvim_feedkeys(vim.fn['copilot#Accept'](vim.api.nvim_replace_termcodes('<Tab>', true, true, true)), 'n', true)
            end)


        },
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
        },
        { 
            { name = 'vsnip' }, -- For vsnip users.
            { name = 'cmp_tabnine' },
        },
        {
            { name = 'buffer' },

        }),
        formatting = {
            format = lspkind.cmp_format({with_text = false, maxwidth = 50})
        }
    })

    local on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        -- Mappings.
        local opts = { noremap=true, silent=true }

        -- See `:help vim.lsp.*` for documentation on any of the below functions
        buf_set_keymap('n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', '\\i', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        buf_set_keymap('n', '\\n', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', '\\N', '<cmd>lua vim.lsp.util.rename()<CR>', opts)
        buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        buf_set_keymap('n', '\\r', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
        buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
        buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
        buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
        buf_set_keymap('n', '\\f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    end

    -- Setup lspconfig.
    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
    local servers = { 'pyright', 'rust_analyzer', 'svelte', "cssls", "jsonls", "eslint", "html"}
    for _, lsp in ipairs(servers) do
        require('lspconfig')[lsp].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150
            }
        }
    end

    require('lspconfig').tsserver.setup {
        -- Needed for inlayHints. Merge this table with your settings or copy
        -- it from the source if you want to add your own init_options.
        init_options = require("nvim-lsp-ts-utils").init_options,
        --
        on_attach = function(client, bufnr)
            local ts_utils = require("nvim-lsp-ts-utils")

            -- defaults
            ts_utils.setup({
                debug = false,
                disable_commands = false,
                enable_import_on_completion = false,

                -- import all
                import_all_timeout = 5000, -- ms
                -- lower numbers = higher priority
                import_all_priorities = {
                    same_file = 1, -- add to existing import statement
                    local_files = 2, -- git files or files with relative path markers
                    buffer_content = 3, -- loaded buffer content
                    buffers = 4, -- loaded buffer names
                },
                import_all_scan_buffers = 100,
                import_all_select_source = false,
                -- if false will avoid organizing imports
                always_organize_imports = true,

                -- filter diagnostics
                filter_out_diagnostics_by_severity = {},
                filter_out_diagnostics_by_code = {},

                -- inlay hints
                auto_inlay_hints = true,
                inlay_hints_highlight = "Comment",
                inlay_hints_priority = 200, -- priority of the hint extmarks
                inlay_hints_throttle = 150, -- throttle the inlay hint request
                inlay_hints_format = { -- format options for individual hint kind
                    Type = {},
                    Parameter = {},
                    Enum = {},
                    -- Example format customization for `Type` kind:
                    -- Type = {
                    --     highlight = "Comment",
                    --     text = function(text)
                    --         return "->" .. text:sub(2)
                    --     end,
                    -- },
                },

                -- update imports on file move
                update_imports_on_move = false,
                require_confirmation_on_move = false,
                watch_dir = nil,
            })

            -- required to fix code action ranges and filter diagnostics
            ts_utils.setup_client(client)

            client.server_capabilities.document_formatting = false
            client.server_capabilities.document_range_formatting = false

            on_attach(client, bufnr)
        end,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150
        }

    }
EOF
