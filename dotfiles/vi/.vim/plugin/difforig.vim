function! s:err(message)
  echohl ErrorMsg | echo a:message | echohl None
endfunction

function! s:warn(message)
  echohl WarningMsg | echo a:message | echohl None
endfunction

function! DiffOrig()
  let filename = expand('%')

  if empty(filename)
    call s:err('No file name')
    return -1
  elseif !filereadable(filename)
    call s:err('Not a file')
    return -1
  endif

  let file = fnameescape(filename)
  let edit = tempname()

  silent execute 'keepalt write! '.edit
  let is_diff = system('diff -q '.file.' '.edit)

  if empty(is_diff)
    call s:warn('No changes')
    return -1
  endif

  silent execute '!diff -p '.file.' '.edit

  silent !clear -x
  redraw!

  call delete(edit)
endfunction

command! -nargs=0 DiffOrig call DiffOrig()
