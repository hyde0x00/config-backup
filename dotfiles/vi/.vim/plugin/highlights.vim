function! s:err(message)
  echohl ErrorMsg | echo a:message | echohl None
endfunction

let s:highlights = {}

function! s:AddHighlight(group, pattern, priority)
    let s:highlights[a:group] = {
        \ 'group': a:group,
        \ 'pattern': a:pattern,
        \ 'priority': a:priority,
        \ 'id': -1
    \ }
endfunction

call s:AddHighlight('LineLengthLimit', '\%80v', 100)
call s:AddHighlight('TrailingWhiteSpace', '\s\+$', 1)

function! HaveHighlight(group)
    if !has_key(s:highlights, a:group)
        call s:err('Unknown highlight group: ' . a:group)
        return
    endif

    let hl = s:highlights[a:group]

    if hl.id != -1
        return v:true
    else
        return v:false
    endif
endfunction

function! s:ToggleHighlight(group, enable)
    if !has_key(s:highlights, a:group)
        call s:err('Unknown highlight group: ' . a:group)
        return
    endif

    let hl = s:highlights[a:group]

    if a:enable
        if hl.id != -1
            silent! call matchdelete(hl.id)
        endif
        let hl.id = matchadd(hl.group, hl.pattern, hl.priority)
    else
        if hl.id != -1
            silent! call matchdelete(hl.id)
            let hl.id = -1
        endif
    endif
endfunction

function! s:DoLineLengthLimitHighlight()
    call s:ToggleHighlight('LineLengthLimit', v:true)
endfunction

function! s:NoLineLengthLimitHighlight()
    call s:ToggleHighlight('LineLengthLimit', v:false)
endfunction

function! s:DoTrailingWhiteSpaceHighlight()
    call s:ToggleHighlight('TrailingWhiteSpace', v:true)
endfunction

function! s:NoTrailingWhiteSpaceHighlight()
    call s:ToggleHighlight('TrailingWhiteSpace', v:false)
endfunction

command! -nargs=0 DoLineLengthLimit call s:DoLineLengthLimitHighlight()
command! -nargs=0 NoLineLengthLimit call s:NoLineLengthLimitHighlight()
command! -nargs=0 DoTrailingWhiteSpace call s:DoTrailingWhiteSpaceHighlight()
command! -nargs=0 NoTrailingWhiteSpace call s:NoTrailingWhiteSpaceHighlight()
