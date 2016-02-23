" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
  set nocompatible               " Be iMproved
endif

" NeoBundle 초기화

set runtimepath^=$XDG_CONFIG_HOME/nvim/bundle/neobundle.vim/
call neobundle#begin(expand('$XDG_CONFIG_HOME/nvim/neobundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'dkprice/vim-easygrep'

NeoBundleLazy 'astralhpi/CoffeeTags' 
NeoBundleLazy 'astralhpi/deoplete-omnisharp' 
NeoBundleLazy 'OmniSharp/omnisharp-vim'
NeoBundleLazy 'OrangeT/vim-csharp'

call neobundle#end()
NeoBundleCheck

" 기본 설정
filetype plugin indent on
syntax on
let base16colorspace=256
set background=dark
colorscheme base16-tomorrow
set ts=4
set sw=4
set visualbell
set number
set autoread
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set hidden
set previewheight=5


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
nmap œ :bd<CR>
nmap « :TagbarToggle<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" 플러그인 설정
" deoplete
let g:deoplete#enable_at_startup = 1

" NERDTree
map <C-\> :NERDTreeToggle<CR>

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" airline 설정
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" CoffeeTags 설정
let g:CoffeeAutoTagIncludeVars = 1
autocmd FileType coffee NeoBundleSource CoffeeTags

" OmniSharp-vim 설정
autocmd FileType cs NeoBundleSource omnisharp-vim
autocmd FileType cs NeoBundleSource deoplete-omnisharp 

let g:OmniSharp_selector_ui = 'ctrlp'
let g:OmniSharp_server_type = 'v1'

" vim-csharp 설정
autocmd FileType cs NeoBundleSource vim-csharp

"autocmd FileType python NeoBundleSource deoplete-jedi

