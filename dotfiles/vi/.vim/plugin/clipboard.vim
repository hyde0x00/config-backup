function! PreserveClipboard()
  call system('xsel -ib', getreg('+'))
endfunction

function! PreserveClipboadAndSuspend()
  call PreserveClipboard()
  suspend
endfunction
  
function! SetClipboard()
  if !executable('xsel')
    echo '[SetClipboard] Executable not found: xsel'
    return -1
  endif 
  set clipboard=unnamedplus
  autocmd VimLeave * call PreserveClipboard()
  nnoremap <silent> <C-Z> :call PreserveClipboadAndSuspend()<CR>
  vnoremap <silent> <C-Z> :<C-U>call PreserveClipboadAndSuspend()<CR>
endfunction 

call SetClipboard()
