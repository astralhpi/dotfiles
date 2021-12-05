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
au FileType * setlocal conceallevel=0 

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'nvim-lua/plenary.nvim'
" Plugins - Buffer
Plug 'qpkorr/vim-bufkill'
Plug 'phaazon/hop.nvim'

" Plugins - Navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'

" Plugins - UI
Plug 'edkolev/tmuxline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Shougo/denite.nvim'
Plug 'Shougo/echodoc.vim'
Plug 'kyazdani42/nvim-web-devicons'

" Plugins - Text
Plug 'mg979/vim-visual-multi'
Plug 'Yggdroot/indentLine'

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


" IDE - Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'branch' : '0.5-compat'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects', {'branch' : '0.5-compat'}

" IDE - Snippet
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'


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
Plug 'mattn/emmet-vim', { 'for': 'html' }
Plug 'dNitro/vim-pug-complete', { 'for': ['jade', 'pug'] }

" IDE - elixir
Plug 'elixir-lang/vim-elixir'

" IDE - Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }

" IDE - Solidity
Plug 'tomlion/vim-solidity'

" IDE - Rust
Plug 'rust-lang/rust.vim'

" IDE - Python
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }

" IDE - helm
Plug 'towolf/vim-helm'

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
nmap <C-\> :NERDTreeToggle<CR>

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

"indentLine
let g:indentLine_char= '▏'
" auto-pairs
let g:AutoPairsMultilineClose = 0


" json
let g:vim_json_syntax_conceal = 0

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

lua <<EOF
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
                select = true,
            })


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
        buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        buf_set_keymap('n', '\\r', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
        buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
        buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
        buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
        buf_set_keymap('n', '\\f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    end

    -- Setup lspconfig.
    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    local servers = { 'pylsp', 'rust_analyzer', 'svelte', 'tsserver', "cssls", "jsonls", "eslint" }
    for _, lsp in ipairs(servers) do
        require('lspconfig')[lsp].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150
            }
        }
    end
EOF
