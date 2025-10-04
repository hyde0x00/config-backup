let s:commands = {
\   'find': 'f',
\   'search': 's', 
\   'note': 'note'
\ }

function! s:err(message)
  echohl ErrorMsg | echo a:message | echohl None
endfunction

function! s:warn(message)
  echohl WarningMsg | echo a:message | echohl None
endfunction

function! s:grep_escape(str)
  return shellescape(escape(a:str, '-~[]^$.*\'))
endfunction

function! s:escape_and_expand_args(args_list)
  let args = map(copy(a:args_list), 'escape(v:val, " ")')
  return map(args, 'substitute(v:val, "^\\~", $HOME, "")')
endfunction

function! s:fzf_select_and_jump(shell_command, fields_count, ...)
  let args_string = a:0 > 0 ? join(s:escape_and_expand_args(a:1)) : ''

  let result = system(a:shell_command . ' -p ' . args_string)[0:-2]
  let status = v:shell_error

  silent !clear -x
  redraw!

  if status == 1 " Nothing found
    call s:err('Nothing found')
    return
  elseif status == 2 " Selection aborted
    return
  elseif empty(result)
    return
  endif

  if a:fields_count == 1
    let file = fnameescape(result)
    execute 'edit! ' . file
  elseif a:fields_count == 2
    let fields = matchlist(result, '^\(.*\):\([0-9]\+\):')
    let file = fnameescape(fields[1])
    let line = fields[2]
    execute 'edit! +' . line . ' ' . file
  endif
endfunction

function! s:fzf_find_file(...)
  let cmd = s:commands.find
  if !executable(cmd)
    call s:err('Executable not found: ' . cmd)
    return
  endif
  call s:fzf_select_and_jump(cmd, 1, a:000)
endfunction

function! s:fzf_search(...)
  let cmd = s:commands.search
  if !executable(cmd)
    call s:err('Executable not found: ' . cmd)
    return
  endif
  if &ignorecase
    let cmd .= ' -c'
  endif
  call s:fzf_select_and_jump(cmd, 2, a:000)
endfunction

function! s:fzf_search_word()
  let word = expand('<cword>')
  if empty(word)
    call s:err('No word under cursor')
    return
  endif
  call s:fzf_search('-w', s:grep_escape(word))
endfunction

function! s:fzf_search_selection()
  let start = getpos("'<")[2] - 1
  let end = getpos("'>")[2] - 1
  let selection = getline(line('.'))[start:end]
  if empty(selection)
    call s:err('Selection is empty')
    return
  endif
  call s:fzf_search(s:grep_escape(selection))
endfunction

function! s:fzf_note(...)
  let cmd = s:commands.note
  if !executable(cmd)
    call s:err('Executable not found: ' . cmd)
    return
  endif
  if !a:0
    call s:fzf_select_and_jump(cmd, 1)
  else
    call s:fzf_select_and_jump(cmd, 2, a:000)
  endif
endfunction

command! -nargs=* -complete=dir Find call s:fzf_find_file(<f-args>)
command! -nargs=* -complete=file Search call s:fzf_search(<f-args>)
command! -nargs=0 SearchWord call s:fzf_search_word()
command! -nargs=0 -range SearchSelection call s:fzf_search_selection()
command! -nargs=* -complete=dir Note call s:fzf_note(<f-args>)
