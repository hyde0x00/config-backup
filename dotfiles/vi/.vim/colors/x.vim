hi clear
let g:colors_name = 'x'

hi Normal           ctermfg=none  ctermbg=0     cterm=none
hi Comment          ctermfg=9     ctermbg=none  cterm=none
hi Todo             ctermfg=9     ctermbg=none  cterm=none
hi Statement        ctermfg=11    ctermbg=none  cterm=none
hi Constant         ctermfg=10    ctermbg=none  cterm=none
hi Special          ctermfg=10    ctermbg=none  cterm=none
hi PreProc          ctermfg=none  ctermbg=none  cterm=none
hi NonText          ctermfg=8     ctermbg=none  cterm=none
hi EndofBuffer      ctermfg=8     ctermbg=none  cterm=none
hi Folded           ctermfg=8     ctermbg=none  cterm=none
hi FoldColumn       ctermfg=8     ctermbg=none  cterm=none
hi LineNr           ctermfg=8     ctermbg=none  cterm=none
hi ColorColumn      ctermfg=none  ctermbg=235   cterm=none
hi CursorLine       ctermfg=none  ctermbg=234   cterm=none
hi CursorLineNr     ctermfg=8     ctermbg=none  cterm=none
hi CursorColumn     ctermfg=none  ctermbg=none  cterm=none
hi Search           ctermfg=15    ctermbg=5     cterm=none
hi CurSearch        ctermfg=15    ctermbg=2     cterm=none
hi IncSearch        ctermfg=15    ctermbg=2     cterm=none
hi MatchParen       ctermfg=15    ctermbg=6     cterm=none
hi Visual           ctermfg=none  ctermbg=4     cterm=none
hi StatusLine       ctermfg=none  ctermbg=none  cterm=reverse
hi StatusLineTerm   ctermfg=none  ctermbg=none  cterm=reverse
hi StatusLineNC     ctermfg=8     ctermbg=none  cterm=reverse
hi StatusLineTermNC ctermfg=8     ctermbg=none  cterm=reverse
hi VertSplit        ctermfg=8     ctermbg=none  cterm=none
hi Pmenu            ctermfg=none  ctermbg=none  cterm=none
hi PmenuSbar        ctermfg=none  ctermbg=none  cterm=none
hi PmenuSel         ctermfg=none  ctermbg=none  cterm=reverse
hi PmenuThumb       ctermfg=none  ctermbg=8     cterm=none
hi TabLine          ctermfg=none  ctermbg=none  cterm=reverse
hi TabLineFill      ctermfg=8     ctermbg=none  cterm=reverse
hi TabLineSel       ctermfg=15    ctermbg=none  cterm=none
hi ErrorMsg         ctermfg=15    ctermbg=1     cterm=none
hi ModeMsg          ctermfg=none  ctermbg=none  cterm=none
hi MoreMsg          ctermfg=none  ctermbg=none  cterm=none
hi WarningMsg       ctermfg=none  ctermbg=none  cterm=none
hi SpellBad         ctermfg=9     ctermbg=none  cterm=none
hi SpellCap         ctermfg=14    ctermbg=none  cterm=none
hi SpellLocal       ctermfg=13    ctermbg=none  cterm=none
hi SpellRare        ctermfg=13    ctermbg=none  cterm=none
hi Conceal          ctermfg=8     ctermbg=none  cterm=none
hi Invisible        ctermfg=8     ctermbg=none  cterm=none
hi SpecialKey       ctermfg=8     ctermbg=none  cterm=none
hi Underlined       ctermfg=none  ctermbg=none  cterm=underline
hi Directory        ctermfg=none  ctermbg=none  cterm=none
hi Error            ctermfg=none  ctermbg=none  cterm=none
hi Function         ctermfg=none  ctermbg=none  cterm=none
hi Identifier       ctermfg=none  ctermbg=none  cterm=none
hi SignColumn       ctermfg=none  ctermbg=none  cterm=none
hi Title            ctermfg=none  ctermbg=none  cterm=none
hi Type             ctermfg=none  ctermbg=none  cterm=none
hi Question         ctermfg=none  ctermbg=none  cterm=none
hi QuickFixLine     ctermfg=none  ctermbg=none  cterm=none
hi WildMenu         ctermfg=none  ctermbg=none  cterm=none

hi DiffAdd     ctermfg=none ctermbg=22   cterm=none
hi DiffChange  ctermfg=none ctermbg=22   cterm=none
hi DiffText    ctermfg=none ctermbg=28   cterm=none

hi DiffDelete  ctermfg=124  ctermbg=52   cterm=none
hi diffAdded   ctermfg=10   ctermbg=none cterm=none
hi diffRemoved ctermfg=9    ctermbg=none cterm=none
hi diffLine    ctermfg=8    ctermbg=none cterm=none

hi! link diffChanged   Normal
hi! link diffIndexLine Normal
hi! link diffFile      Normal
hi! link diffNewFile   Normal
hi! link diffOldFile   Normal
hi! link diffSubname   Normal

hi! link htmlLink                    Normal
hi! link htmlBoldItalic              Normal
hi! link htmlBoldItalicUnderline     Normal
hi! link htmlBold                    Normal
hi! link htmlBoldUnderlineItalic     Normal
hi! link htmlBoldUnderline           Normal
hi! link htmlItalicBold              Normal
hi! link htmlItalicBoldUnderline     Normal
hi! link htmlItalic                  Normal
hi! link htmlItalicUnderlineBold     Normal
hi! link htmlItalicUnderline         Normal
hi! link htmlUnderlineBoldItalic     Normal
hi! link htmlUnderlineBold           Normal
hi! link htmlUnderlineItalicBold     Normal
hi! link htmlUnderlineItalic         Normal
hi! link htmlUnderline               Normal
hi! link markdownBoldDelimiter       Normal
hi! link markdownBoldItalicDelimiter Normal
hi! link markdownBoldItalic          Normal
hi! link markdownBold                Normal
hi! link markdownCodeDelimiter       Normal
hi! link markdownItalicDelimiter     Normal
hi! link markdownItalic              Normal
hi! link markdownStrikeDelimiter     Normal
hi! link markdownStrike              Normal

if 0
  " hi! WhiteSpace ctermfg=none ctermbg=9
  " hi! WhiteSpace ctermfg=none ctermbg=124
  hi WhiteSpace ctermfg=none ctermbg=88
  " hi! WhiteSpace ctermfg=none ctermbg=52
  match WhiteSpace '\s\+$'
endif

if 0
  hi MyColorColumn ctermfg=none ctermbg=88
  call matchadd('MyColorColumn', '\%81v')
endif
