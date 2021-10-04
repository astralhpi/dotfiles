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
set colorcolumn=80
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
" Plugins - Buffer
Plug 'qpkorr/vim-bufkill'

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

" Plugins - Text
Plug 'mg979/vim-visual-multi'
Plug 'Yggdroot/indentLine'

Plug 'simnalamburt/vim-mundo' " Undo Tree

" Plugins - IDE
" IDE - Common 
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'antoinemadec/coc-fzf'
Plug 'jiangmiao/auto-pairs'
Plug 'elzr/vim-json'
Plug 'sheerun/vim-polyglot'
Plug 'liuchengxu/vista.vim' " For symbol tree
Plug 'tpope/vim-fugitive' " Git commands
Plug 'airblade/vim-gitgutter'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'} " Semantic Highlighting
Plug 'tyru/caw.vim' " Comment
Plug 'Shougo/context_filetype.vim' " Change file type by context
Plug 'janko-m/vim-test' " Test Commands

" IDE - Snippet
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'


" IDE - Jenkinsfile
Plug 'martinda/Jenkinsfile-vim-syntax'

" IDE - Dart
Plug 'dart-lang/dart-vim-plugin'

" IDE - Python
Plug 'psf/black', { 'tag': '19.10b0' }
Plug 'manicmaniac/coconut.vim'

" IDE - Swift
Plug 'keith/swift.vim'

" IDE - Kotln
Plug 'udalov/kotlin-vim'

" IDE - Web
Plug 'digitaltoad/vim-pug'
Plug 'posva/vim-vue'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
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

call plug#end()


" Theme
packadd! dracula_pro
let g:dracula_colorterm = 0
colorscheme dracula_pro

set background=dark
autocmd BufEnter * if &previewwindow | setlocal nobuflisted | endif

let g:indentLine_color_term = 238
let g:indentLine_color_gui='#424450'
hi ColorColumn ctermbg=238 guibg=#424450


hi Statement ctermfg=212 guifg=#FF79C6 cterm=bold gui=bold

function! MyHighlights()
    hi semshiLocal           ctermfg=255 guifg=#f8f8f2
    hi semshiGlobal          ctermfg=255 guifg=#f8f8f2 cterm=bold gui=bold
    hi semshiImported        ctermfg=215 guifg=#FFB86C cterm=bold gui=bold
    hi semshiParameter       ctermfg=117 guifg=#8BE9FD
    hi semshiParameterUnused ctermfg=117 guifg=#8BE9FD cterm=underline gui=underline
    hi semshiFree            ctermfg=212 guifg=#FF79C6
    hi semshiBuiltin         ctermfg=141 guifg=#BD93F9
    hi semshiAttribute       ctermfg=255 guifg=#f8f8f2
    hi semshiSelf            ctermfg=141 guifg=#BD93F9
    hi semshiUnresolved      ctermfg=228 guifg=#F1FA8C cterm=underline gui=underline
    hi semshiSelected        ctermfg=255 guifg=#f8f8f2 ctermbg=239 guibg=#44475A

    hi semshiErrorSign       ctermfg=255 guifg=#f8f8f2 ctermbg=203 guibg=#FF5555
    hi semshiErrorChar       ctermfg=255 guifg=#f8f8f2 ctermbg=203 guibg=#FF5555
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
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--preview', 'bat --style=numbers --color=always --line-range :200 {}']}, <bang>0)
map <M-w> :Windows<CR>

" coc-fzf
let g:coc_fzf_preview = 'right:50%'
let g:coc_fzf_opts = ['--multi', '--bind', 'alt-a:select-all,alt-d:deselect-all']
map <M-t> :CocFzfList symbols<CR>
map <leader>p :CocFzfList commands<CR>
map <C-b> :Buffers<CR>


"vista
let g:vista_fzf_preview = ['right:50%']
let g:vista_default_executive = 'coc'
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_fzf_opt = ['--multi', '--bind', 'alt-a:select-all,alt-d:deselect-all']

" NERDTree
let g:NERDTreeNodeDelimiter = "\u00a0"
nmap <C-\> :NERDTreeToggle<CR>

" Vista
nmap « :Vista coc<CR>
nmap <C-t> :Vista finder coc<CR>

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" ultisnips
let g:UltiSnipsExpandTrigger="<C-e>"
set completeopt-=preview
set completeopt+=noinsert
set completeopt+=noselect


"indentLine
let g:indentLine_char= '▏'
" auto-pairs
let g:AutoPairsMultilineClose = 0


" json
let g:vim_json_syntax_conceal = 0

" vue
autocmd FileType vue syntax sync fromstart

" coc
function! ExpandLspSnippet()
    call UltiSnips#ExpandSnippetOrJump()
    if !pumvisible() || empty(v:completed_item)
        return ''
    endif

    " only expand Lsp if UltiSnips#ExpandSnippetOrJump not effect.
    let l:value = v:completed_item['word']
    let l:matched = len(l:value)
    if l:matched <= 0
        return ''
    endif

    " remove inserted chars before expand snippet
    if col('.') == col('$')
        let l:matched -= 1
        exec 'normal! ' . l:matched . 'Xx'
    else
        exec 'normal! ' . l:matched . 'X'
    endif

    if col('.') == col('$') - 1
        " move to $ if at the end of line.
        call cursor(line('.'), col('$'))
    endif

    " expand snippet now.
    call UltiSnips#Anon(l:value)
    return ''
endfunction
imap <C-k> <C-R>=ExpandLspSnippet()<CR>


inoremap <expr> <cr> pumvisible() ? "\<C-g> \<cr>" : "\<cr>"
inoremap <expr> <C-n> pumvisible() ? "\<C-n>": coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-y>" : "\<Tab>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<s-tab>'

autocmd FileType c,cpp,python,javascript,typescript,go,rust map <C-]> <Plug>(coc-definition)
map <leader>r <Plug>(coc-references) 
map <leader>n <Plug>(coc-rename) 
map <leader>f <Plug>(coc-format)

" caw
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
