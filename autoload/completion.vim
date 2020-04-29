" completion (v.0.1): completion function.
" author: Henri Cattoire.

" AergiaComplete {{{
function! completion#AergiaComplete()
  let l:line = getline('.')[:col('.')]
  let l:start = col('.') - 1

  while l:start > 0 && l:line[l:start - 1] =~ '[A-Za-z0-9]'
    let l:start -= 1
  endwhile

  let l:base = l:line[l:start:]
  echom  l:base

  let l:res = []
  if &filetype !=? ''
    call completion#AddItems(l:res, globpath(g:aergia_snippets, '**/' . &filetype . '[_]' . l:base . '*', 0, 1))
  endif

  call completion#AddItems(l:res,
        \ map(globpath(g:aergia_snippets, 'global_' . l:base . '*', 0, 1), "substitute(v:val, '.*/', '', '')"))

  call complete(l:start + 1, l:res)
  return ''
endfunction
" }}}
" AddItems {{{
function! completion#AddItems(res, items)
  let l:i = 0
  while l:i < len(a:items)
    let l:snippet = split(substitute(a:items[l:i], '.*/', '', ''), '_')
    call add(a:res, { "word": l:snippet[1], "menu": "[" . l:snippet[0] . "]", })
    let l:i += 1
  endwhile
endfunction
" }}}