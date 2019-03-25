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
set cmdheight=2

" always show signcolumns
set signcolumn=yes

" plugins
call plug#begin('~/.vim/plugged')

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

Plug 'eugen0329/vim-esearch'
Plug 'majutsushi/tagbar'
Plug 'manicmaniac/coconut.vim'
Plug 'guersam/vim-j'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'cakebaker/scss-syntax.vim'
Plug 'tyru/caw.vim'
Plug 'Shougo/context_filetype.vim'
Plug 'posva/vim-vue'
Plug 'digitaltoad/vim-pug'
Plug 'dNitro/vim-pug-complete', { 'for': ['jade', 'pug'] }
Plug 'tomlion/vim-solidity'
Plug 'rust-lang/rust.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Shougo/denite.nvim'
Plug 'Shougo/echodoc.vim'
Plug 'Shougo/neco-vim'

Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-dispatch'
Plug 'jiangmiao/auto-pairs'
Plug 'janko-m/vim-test'
Plug 'jalvesaq/vimcmdline'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'dkprice/vim-easygrep'
Plug 'wesleyche/SrcExpl'
Plug 'Yggdroot/indentLine'
Plug 'qpkorr/vim-bufkill'
Plug 'dracula/vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" javascript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" Language 서포트
" coffeescript
Plug 'kchmck/vim-coffee-script'

" csharp
Plug 'OrangeT/vim-csharp', { 'for': 'csharp'}

" typescript
Plug 'HerringtonDarkholme/yats.vim'

" json
Plug 'elzr/vim-json'

" html
Plug 'mattn/emmet-vim', { 'for': 'html' }

" Elixir
Plug 'elixir-lang/vim-elixir'
Plug 'thinca/vim-ref'

call plug#end()


" Theme
set background=dark
colorscheme dracula
hi ColorColumn ctermbg=60
let g:ackprg = 'ag --vimgrep'
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
nmap <M-}> :bnext<CR>
nmap ” :bprevious<CR>
nmap <M-{> :bprevious<CR>
nmap † :enew<CR>
nmap <M-t> :enew<CR>
nmap œ :BD<CR>
nmap <M-q> :BD<CR>
nmap » :TagbarToggle<CR>
nmap <M-\> :TagbarToggle<CR>


nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" 플러그인 설정
" fzf
nmap <C-p> :FZF<CR>
function! s:tags_sink(line)
  let parts = split(a:line, '\t\zs')
  let excmd = matchstr(parts[2:], '^.*\ze;"\t')
  execute 'silent e' parts[1][:-2]
  let [magic, &magic] = [&magic, 0]
  execute excmd
  let &magic = magic
endfunction

function! s:tags()
  if empty(tagfiles())
    echohl WarningMsg
    echom 'Preparing tags'
    echohl None
    call system('ctags -R')
  endif

  call fzf#run({
  \ 'source':  'cat '.join(map(tagfiles(), 'fnamemodify(v:val, ":S")')).
  \            '| grep -v -a ^!',
  \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
  \ 'down':    '40%',
  \ 'sink':    function('s:tags_sink')})
endfunction

command! Tags call s:tags()

function! s:align_lists(lists)
  let maxes = {}
  for list in a:lists
    let i = 0
    while i < len(list)
      let maxes[i] = max([get(maxes, i, 0), len(list[i])])
      let i += 1
    endwhile
  endfor
  for list in a:lists
    call map(list, "printf('%-'.maxes[v:key].'s', v:val)")
  endfor
  return a:lists
endfunction

function! s:btags_source()
  let lines = map(split(system(printf(
    \ 'ctags -f - --sort=no --excmd=number --language-force=%s %s',
    \ &filetype, expand('%:S'))), "\n"), 'split(v:val, "\t")')
  if v:shell_error
    throw 'failed to extract tags'
  endif
  return map(s:align_lists(lines), 'join(v:val, "\t")')
endfunction

function! s:btags_sink(line)
  execute split(a:line, "\t")[2]
endfunction

function! s:btags()
  try
    call fzf#run({
    \ 'source':  s:btags_source(),
    \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
    \ 'down':    '40%',
    \ 'sink':    function('s:btags_sink')})
  catch
    echohl WarningMsg
    echom v:exception
    echohl None
  endtry
endfunction

command! BTags call s:btags()

function! s:line_handler(l)
  let keys = split(a:l, ':\t')
  exec 'buf' keys[0]
  exec keys[1]
  normal! ^zz
endfunction

function! s:buffer_lines()
  let res = []
  for b in filter(range(1, bufnr('$')), 'buflisted(v:val)')
    call extend(res, map(getbufline(b,0,"$"), 'b . ":\t" . (v:key + 1) . ":\t" . v:val '))
  endfor
  return res
endfunction

command! FZFLines call fzf#run({
\   'source':  <sid>buffer_lines(),
\   'sink':    function('<sid>line_handler'),
\   'options': '--extended --nth=3..',
\   'down':    '60%' 
\})

function! s:ag_to_qf(line)
  let parts = split(a:line, ':')
  return {'filename': parts[0], 'lnum': parts[1], 'col': parts[2],
        \ 'text': join(parts[3:], ':')}
endfunction

function! s:ag_handler(lines)
  if len(a:lines) < 2 | return | endif

  let cmd = get({'ctrl-x': 'split',
               \ 'ctrl-v': 'vertical split',
               \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')
  let list = map(a:lines[1:], 's:ag_to_qf(v:val)')

  let first = list[0]
  execute cmd escape(first.filename, ' %#\')
  execute first.lnum
  execute 'normal!' first.col.'|zz'

  if len(list) > 1
    call setqflist(list)
    copen
    wincmd p
  endif
endfunction

command! -nargs=* Ag call fzf#run({
\ 'source':  printf('ag --nogroup --column --color "%s"',
\                   escape(empty(<q-args>) ? '^(?=.)' : <q-args>, '"\')),
\ 'sink*':    function('<sid>ag_handler'),
\ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. '.
\            '--multi --bind=ctrl-a:select-all,ctrl-d:deselect-all '.
\            '--color hl:68,hl+:110',
\ 'down':    '50%'
\ })

nmap <C-t> :Tags<CR>
nmap <C-b> :BTags<CR>
nmap <C-g> :FZFLines<CR>

" nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" deoplete
let g:deoplete#auto_complete_start_length = 2
let g:deoplete#enable_at_startup = 1
let g:deoplete#tag#cache_limit_size = 3000000
let g:deoplete#max_list = 40
let g:deoplete#file#enable_buffer_path = 1

" NERDTree
nmap <C-\> :NERDTreeToggle<CR>

" ultisnips
let g:UltiSnipsExpandTrigger="<C-e>"
set completeopt-=preview
set completeopt+=noinsert
set completeopt+=noselect

" airline 설정
let g:airline#extensions#tabline#enabled = 1

let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
let airline#extensions#coc#error_symbol = 'Error:'
let airline#extensions#coc#warning_symbol = 'Warning:'
let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" CoffeeTags 설정
let g:CoffeeAutoTagDisabled=1
let g:CoffeeAutoTagIncludeVars = 1

let g:OmniSharp_selector_ui = 'ctrlp'
let g:OmniSharp_server_type = 'v1'

" SrcExpl
let g:SrcExpl_isUpdateTags = 0

"indentLine
let g:indentLine_char = '│'
let g:indentLine_color_term = 239

" auto-pairs
let g:AutoPairsMultilineClose = 0


" json
let g:vim_json_syntax_conceal = 0


" conceal
set conceallevel=0
au FileType * setlocal conceallevel=0 
autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
autocmd BufWrite *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

autocmd FileType vue syntax sync fromstart

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


" coc
inoremap <expr> <cr> pumvisible() ? "\<C-g> \<cr>" : "\<cr>"
inoremap <expr> <C-n> pumvisible() ? "\<C-n>": coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-y>" : "\<Tab>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<s-tab>'

au FileType c,cpp,python,javascript,typescript,go map <C-]> <Plug>(coc-definition)
map <leader>r <Plug>(coc-references) 
map <leader>n <Plug>(coc-rename) 
map <leader>f <Plug>(coc-format)

