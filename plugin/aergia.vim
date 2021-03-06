" aergia (v.0.3): small plugin that tries to act as a snippet manager.
" author: Henri Cattoire.

" provide means to prevent loading
if exists('g:aergia_loaded')
  finish
endif
let g:aergia_loaded = 1
" temporarly set cpo to vim default
let s:save_cpo = &cpo
set cpo&vim

" Global Variables {{{
if !exists('g:aergia_snippets')
  let g:aergia_snippets = expand('~/.vim/bundle/aergia/snippets')
else
  let g:aergia_snippets = expand(g:aergia_snippets)
endif

if !exists('g:aergia_key')
  let g:aergia_key = '<c-a>'
endif

if exists('g:aergia_expand')
  augroup aergia_expand
    autocmd!
    autocmd CompleteDone * call aergia#completion#AergiaExpand(v:completed_item)
  augroup end
endif
" }}}
" Mappings {{{
inoremap <silent> <Plug>(aergia) <esc>:call aergia#ReplSnippet()<cr>
snoremap <silent> <Plug>(aergia) <esc>:call aergia#ReplSnippet()<cr>
execute "imap " . g:aergia_key . " <Plug>(aergia)"
execute "smap " . g:aergia_key . " <Plug>(aergia)"
" }}}
" Commands {{{
command -nargs=1 AergiaAddSnippet :call aergia#commands#AergiaAddSnippet(<f-args>)
command -nargs=1 -complete=customlist,aergia#completion#ListSnippets AergiaEditSnippet   :call aergia#commands#AergiaEditSnippet(<f-args>)
command -nargs=1 -complete=customlist,aergia#completion#ListSnippets AergiaRemoveSnippet :call aergia#commands#AergiaRemoveSnippet(<f-args>)
" }}}
let &cpo = s:save_cpo
unlet s:save_cpo
