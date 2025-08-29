function! s:err(message)
  echohl ErrorMsg | echo a:message | echohl None
endfunction
 
function! s:warn(message)
  echohl WarningMsg | echo a:message | echohl None
endfunction
 
function! s:FzfJump(shell_command, fields_count, ...)
  let flags = '-p'
  if a:0 > 0
    let args = map(copy(a:1), 'escape(v:val, " ")')
    let args = map(args, 'substitute(v:val, "^\\~", $HOME, "")')
    let args = join(args, ' ')
  else
    let args = ''
  endif
  let result = system(a:shell_command.' '.flags.' '.args)[0:-2]
  let status = v:shell_error
  silent !clear -x
  redraw!
  if !&hidden && &modified
    call s:err('E37: No write since last change')
    return
  elseif status == 1 " Nothing to select from
    call s:err('Nothing found')
    return
  elseif status == 2 " Selection aborted
    return
  elseif empty(result)
    return
  endif
  if a:fields_count == 1
    let file = fnameescape(result)
    execute 'edit! '.file
  elseif a:fields_count == 2
    let fields = matchlist(result, '^\(.*\):\([0-9]\+\):')
    let file = fnameescape(fields[1])
    let line = fields[2]
    execute 'edit! +'.line.' '.file
  endif
endfunction
 
function! s:FzfFind(...)
  let cmd = 'f'
  if !executable(cmd)
    call s:err('Executable not found: '.cmd)
    return
  endif
  call s:FzfJump(cmd, 1, a:000)
endfunction
 
function! s:FzfSearch(...)
  let cmd = 's'
  if !executable(cmd)
    call s:err('Executable not found: '.cmd)
    return
  endif
  if &ignorecase
    let cmd .= ' -c'
  endif
  call s:FzfJump(cmd, 2, a:000)
endfunction

function! s:searchescape(str)
  return shellescape(escape(a:str, '-~[]^$.*\'))
endfunction
 
function! s:FzfSearchWord()
  let word = expand('<cword>')
  if empty(word)
    call s:err('No word under cursor')
    return
  endif
  call s:FzfSearch('-w', s:searchescape(word))
endfunction
 
function! s:FzfSearchSelection()
  let start = getpos("'<")[2] - 1
  let end = getpos("'>")[2] - 1
  let selection = getline(line('.'))[start:end]
  if empty(selection)
    call s:err('Selection is empty')
    return
  endif
  call s:FzfSearch(s:searchescape(selection))
endfunction
 
command! -nargs=* -complete=dir Find call s:FzfFind(<f-args>)
command! -nargs=* -complete=file Search call s:FzfSearch(<f-args>)
command! -nargs=0 SearchWord call s:FzfSearchWord()
command! -nargs=0 -range SearchSelection call s:FzfSearchSelection()
 
function! s:FzfNote(...)
  let cmd = 'note'
  if !executable(cmd)
    call s:err('Executable not found: '.cmd)
    return
  endif
  if a:0 == 0
    call s:FzfJump(cmd, 1)
  else
    call s:FzfJump(cmd, 2, a:000)
  endif
endfunction
 
command! -nargs=* -complete=dir Note call s:FzfNote(<f-args>)
