" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
  set nocompatible               " Be iMproved
endif

" NeoBundle 초기화

set runtimepath^=~/.config/nvim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'vim-airline/vim-airline'

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

nmap <C-]> :bnext<CR>
nmap <C-[> :bprevious<CR>

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
