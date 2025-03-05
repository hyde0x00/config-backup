function! s:err(message)
  echohl ErrorMsg | echo a:message | echohl None
endfunction

function! s:warn(message)
  echohl WarningMsg | echo a:message | echohl None
endfunction

function! s:FzfJump(shell_command, field_count, ...)
  let flags = '-p -q'
  if a:0 > 0
    let args = map(copy(a:1), 'escape(v:val, " ")')
    let args = map(args, 'substitute(v:val, "^\\~", $HOME, "")')
    let args = join(args)
  else
    let args = ''
  endif
  let result = system(a:shell_command.' '.flags.' '.args)[0:-2]
  let exit_status = v:shell_error
  silent !clear -x
  redraw!
  if !&hidden && &modified
    call s:err('E37: No write since last change')
    return -1
  elseif exit_status == 1
    call s:err('Nothing found')
    return -1
  elseif exit_status == 2
    return -1
  elseif empty(result)
    return -1
  endif
  let fields = split(result, ':')
  let file = fnameescape(fields[0])
  if bufexists(bufname(file))
    silent execute 'buffer! '.bufnr(file)
  endif
  if a:field_count == 1
    execute 'edit! '.file
  elseif a:field_count >= 2
    let line = fields[1]
    execute 'edit! +'.line.' '.file
  endif
endfunction

function! s:FzfFind(...)
  let command = 'f'
  if !executable(command)
    call s:err('Executable not found: '.command)
    return -1
  endif
  call s:FzfJump(command, 1, a:000)
endfunction

function! s:FzfSearch(...)
  let command = 's'
  if !executable(command)
    call s:err('Executable not found: '.command)
    return -1
  endif
  if &ignorecase
    let command .= ' -c'
  endif
  call s:FzfJump(command, 2, a:000)
endfunction

function! s:grepesc(str)
  return shellescape(escape(a:str, '-~^$.*[]\'), 1)
endfunction!

function! s:FzfSearchSelection()
  let start = getpos("'<")[2] - 1
  let end = getpos("'>")[2] - 1
  let selection = getline(line('.'))[start:end]
  if empty(selection)
    call s:err('Selection is empty')
    return -1
  endif
  call s:FzfSearch(s:grepesc(selection))
endfunction

function! s:FzfSearchWord()
  let word = expand('<cword>')
  if empty(word)
    call s:err('No word under cursor')
    return -1
  endif
  call s:FzfSearch('-w', s:grepesc(word))
endfunction

command! -nargs=* -complete=dir Find call s:FzfFind(<f-args>)
command! -nargs=* -complete=file Search call s:FzfSearch(<f-args>)
command! -nargs=0 -range SearchSelection call s:FzfSearchSelection()
command! -nargs=0 SearchWord call s:FzfSearchWord()
