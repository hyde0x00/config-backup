function! PreserveClipboard()
  call system('xsel --input --clipboard', getreg('+'))
endfunction

function! PreserveClipboadAndSuspend()
  call PreserveClipboard()
  suspend
endfunction
  
function! EnablePreserveClipboard()
  if !executable('xsel')
    echo '[EnablePreserveClipboard] Executable not found: xsel'
    return
  endif
  autocmd VimLeave * call PreserveClipboard()
  nnoremap <silent> <C-Z> :call PreserveClipboadAndSuspend()<CR>
  vnoremap <silent> <C-Z> :<C-U>call PreserveClipboadAndSuspend()<CR>
endfunction 

call EnablePreserveClipboard()
