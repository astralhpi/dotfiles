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

call neobundle#end()
NeoBundleCheck

" 기본 설정
filetype plugin indent on
syntax on

" 단축키 설정
" NERDTree 단축키
map <C-\> :NERDTreeToggle<CR>


