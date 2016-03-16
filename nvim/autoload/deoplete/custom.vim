"=============================================================================
" FILE: custom.vim
" AUTHOR: Shougo Matsushita <Shougo.Matsu at gmail.com>
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
"=============================================================================

function! deoplete#custom#get(source_name) abort "{{{
  let source = copy(deoplete#custom#get_source_var(a:source_name))
  return extend(source, s:custom._, 'keep')
endfunction"}}}

function! deoplete#custom#get_source_var(source_name) abort "{{{
  if !exists('s:custom')
    let s:custom = {}
    let s:custom._ = {}
  endif

  if !has_key(s:custom, a:source_name)
    let s:custom[a:source_name] = {}
  endif

  return s:custom[a:source_name]
endfunction"}}}

function! deoplete#custom#set(source_name, option_name, value) abort "{{{
  for key in split(a:source_name, '\s*,\s*')
    let custom_source = deoplete#custom#get_source_var(key)
    let custom_source[a:option_name] = a:value
  endfor
endfunction"}}}

" vim: foldmethod=marker
