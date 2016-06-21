" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
  set nocompatible               " Be iMproved
endif

" plugin

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'JazzCore/ctrlp-cmatcher'
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-dispatch'
Plug 'scrooloose/syntastic'
Plug 'jiangmiao/auto-pairs'
Plug 'janko-m/vim-test'
Plug 'jalvesaq/vimcmdline'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'dkprice/vim-easygrep'
Plug 'wesleyche/SrcExpl'
Plug 'tacahiroy/ctrlp-funky'
Plug 'Yggdroot/indentLine'
Plug 'qpkorr/vim-bufkill'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'dracula/vim'

" Language 서포트
" coffeescript
Plug 'kchmck/vim-coffee-script'
Plug 'astralhpi/CoffeeTags', { 'for': 'coffee'}

" csharp
Plug 'OmniSharp/omnisharp-vim', { 'for': 'csharp'}
Plug 'astralhpi/deoplete-omnisharp', { 'for': 'csharp'}
Plug 'OrangeT/vim-csharp', { 'for': 'csharp'}

" python
Plug 'zchee/deoplete-jedi', { 'for': 'python'}

" javascript
Plug 'pangloss/vim-javascript', { 'for': 'javascript'}

call plug#end()

" 기본 설정
filetype plugin indent on
syntax on
"let base16colorspace=256
set background=dark
colorscheme dracula
set expandtab
set ts=4
set sw=4
set visualbell
set number
set autoread
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set hidden
set previewheight=5
set colorcolumn=80
let g:ackprg = 'ag --vimgrep'
set clipboard=unnamed
autocmd BufEnter * if &previewwindow | setlocal nobuflisted | endif


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
nmap ” :bprevious<CR>
nmap † :enew<CR>
nmap œ :BD<CR>
nmap » :TagbarToggle<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" 플러그인 설정
" deoplete
let g:deoplete#auto_complete_start_length = 2
let g:deoplete#enable_at_startup = 1
let g:deoplete#tag#cache_limit_size = 3000000
let g:deoplete#max_list = 40
let g:deoplete#file#enable_buffer_path = 1
set completeopt-=preview

" NERDTree
nmap <C-\> :NERDTreeToggle<CR>

" ctrlp
nmap <C-t> :CtrlPTag<CR>
nmap <C-b> :CtrlPBufTag<CR>
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
"let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
let g:ctrlp_buftag_types = {
    \ 'coffee' : {
      \ 'bin': 'coffeetags',
      \ 'args': '-f -',
      \ },
    \ 'javascript' : {
      \ 'bin': 'ctags',
      \ 'args': '-f -',
      \ },
    \ }

" airline 설정
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" CoffeeTags 설정
let g:CoffeeAutoTagDisabled=1
let g:CoffeeAutoTagIncludeVars = 1

let g:OmniSharp_selector_ui = 'ctrlp'
let g:OmniSharp_server_type = 'v1'

"NERDTree
map <leader>f :NERDTreeFind<cr>

"EasyGrep
autocmd VimEnter * GrepProgram ag

" SrcExpl
let g:SrcExpl_isUpdateTags = 0

"indentLine
let g:indentLine_char = '│'

" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"
