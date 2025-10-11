let g:highlight_linelength = get(g:, 'highlight_linelength', 0)
let g:highlight_whitespace = get(g:, 'highlight_whitespace', 0)
let g:highlight_matchparen = get(g:, 'highlight_matchparen', 0)

function! s:EnableMatch(key)
  let l:matches = {
  \   'linelength': {'group': 'LineLengthLimit', 'pattern': '\%' . get(g:, 'linelengthlimit', 0) . 'v', 'priority': 100},
  \   'whitespace': {'group': 'TrailingWhiteSpace', 'pattern': '\s\+$', 'priority': 10}
  \ }

  let l:match = l:matches[a:key]
  let s:{a:key} = matchadd(l:match.group, l:match.pattern, l:match.priority)
  let g:highlight_{a:key} = 1
endfunction

function! s:DisableMatch(key)
  if exists('s:' . a:key)
    call matchdelete(s:{a:key})
  endif
  let g:highlight_{a:key} = 0
endfunction

function! s:ToggleLineLengthLimit()
  if g:highlight_linelength
    call s:DisableMatch('linelength')
  else
    call s:EnableMatch('linelength')
  endif
endfunction

function! s:ToggleTrailingWhitespace()
  if g:highlight_whitespace
    call s:DisableMatch('whitespace')
  else
    call s:EnableMatch('whitespace')
  endif
endfunction

function! s:ToggleMatchParen()
  if exists('g:loaded_matchparen')
    unlet g:loaded_matchparen
  endif
  runtime plugin/matchparen.vim
  let g:highlight_matchparen = !g:highlight_matchparen
  execute g:highlight_matchparen ? ':DoMatchParen' : ':NoMatchParen'
endfunction

if g:highlight_linelength
  call s:EnableMatch('linelength')
endif

if g:highlight_whitespace
  call s:EnableMatch('whitespace')
endif

if !g:highlight_matchparen
  let g:loaded_matchparen = 1
endif

command! LineLengthLimitToggle call s:ToggleLineLengthLimit()
command! TrailingWhitespaceToggle call s:ToggleTrailingWhitespace()
command! MatchParenToggle call s:ToggleMatchParen()
