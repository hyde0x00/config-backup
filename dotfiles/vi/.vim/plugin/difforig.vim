function! s:err(message)
  echohl ErrorMsg | echo a:message | echohl None
endfunction

function! DiffOrig()
  let filename = expand('%')
  if !&modified
    echom 'No changes'
    return
  elseif empty(filename)
    call s:err('No file name')
    return
  elseif !filereadable(filename)
    call s:err('Not a file')
    return
  endif
  let file = fnameescape(filename)
  let edit = tempname()
  silent execute 'keepalt write! ' . edit
  let is_diff = system('diff -q ' . file . ' ' . edit)
  if empty(is_diff)
    echom 'No changes'
    return
  endif
  let cmd = '!diff -p'

  if exists("g:highlight_whitespace") && g:highlight_whitespace
    let cmd .= ' -w'
  endif
  silent execute cmd. ' ' . file . ' ' . edit
  silent !clear -x
  redraw!
  call delete(edit)
endfunction

command! -nargs=0 DiffOrig call DiffOrig()
