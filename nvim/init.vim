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
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'kchmck/vim-coffee-script'

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

" NERDTree
map <C-\> :NERDTreeToggle<CR>

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
