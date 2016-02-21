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
NeoBundle 'zenorocha/dracula-theme', {'rtp': 'vim/'}

call neobundle#end()
NeoBundleCheck

" 기본 설정
filetype plugin indent on
syntax on
color dracula
set ts=4
set sw=4
set visualbell


" 기본 키 설정

" 플러그인 설정
" deoplete
let g:deoplete#enable_at_startup = 1

" NERDTree 단축키
map <C-\> :NERDTreeToggle<CR>

