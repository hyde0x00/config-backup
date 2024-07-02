hi! clear

if version > 580
	if exists("g:syntax_on")
		syntax reset
	endif
endif

let g:colors_name="x"

hi Normal            ctermfg=none  ctermbg=none  cterm=none
hi Comment           ctermfg=9     ctermbg=none  cterm=none
hi Todo              ctermfg=9     ctermbg=none  cterm=none
hi Statement         ctermfg=none  ctermbg=none  cterm=none
hi Constant          ctermfg=none  ctermbg=none  cterm=none
hi Special           ctermfg=none  ctermbg=none  cterm=none
hi Function          ctermfg=none  ctermbg=none  cterm=none
hi Identifier        ctermfg=none  ctermbg=none  cterm=none
hi PreProc           ctermfg=none  ctermbg=none  cterm=none
hi Type              ctermfg=none  ctermbg=none  cterm=none
hi EndofBuffer       ctermfg=8     ctermbg=none  cterm=none
hi Underlined        ctermfg=none  ctermbg=none  cterm=underline
hi Folded            ctermfg=8     ctermbg=none  cterm=none
hi FoldColumn        ctermfg=8     ctermbg=none  cterm=none
hi SignColumn        ctermfg=none  ctermbg=none  cterm=none
hi LineNr            ctermfg=8     ctermbg=none  cterm=none
hi CursorLineNr      ctermfg=8     ctermbg=none  cterm=none
hi ColorColumn       ctermfg=none  ctermbg=235   cterm=none
hi CursorColumn      ctermfg=none  ctermbg=none  cterm=none
hi CursorLine        ctermfg=none  ctermbg=234   cterm=none
hi Search            ctermfg=15    ctermbg=5     cterm=none
hi CurSearch         ctermfg=15    ctermbg=2     cterm=none
hi IncSearch         ctermfg=15    ctermbg=2     cterm=none
hi MatchParen        ctermfg=15    ctermbg=6     cterm=none
hi Visual            ctermfg=none  ctermbg=4     cterm=none
hi Pmenu             ctermfg=none  ctermbg=none  cterm=none
hi PmenuSel          ctermfg=none  ctermbg=none  cterm=reverse
hi PmenuSbar         ctermfg=none  ctermbg=none  cterm=none
hi PmenuThumb        ctermfg=none  ctermbg=8     cterm=none
hi Title             ctermfg=none  ctermbg=none  cterm=none
hi TabLine           ctermfg=none  ctermbg=none  cterm=reverse
hi TabLineSel        ctermfg=none  ctermbg=none  cterm=none
hi TabLineFill       ctermfg=8     ctermbg=none  cterm=reverse
hi StatusLine        ctermfg=none  ctermbg=none  cterm=reverse
hi StatusLineTerm    ctermfg=none  ctermbg=none  cterm=reverse
hi StatusLineNC      ctermfg=8     ctermbg=none  cterm=reverse
hi StatusLineTermNC  ctermfg=8     ctermbg=none  cterm=reverse
hi VertSplit         ctermfg=8     ctermbg=none  cterm=none
hi ModeMsg           ctermfg=none  ctermbg=none  cterm=none
hi ErrorMsg          ctermfg=15    ctermbg=1     cterm=none
hi MoreMsg           ctermfg=none  ctermbg=none  cterm=none
hi Question          ctermfg=none  ctermbg=none  cterm=none
hi WarningMsg        ctermfg=none  ctermbg=none  cterm=none
hi SpellBad          ctermfg=9     ctermbg=none  cterm=underline
hi SpellCap          ctermfg=11    ctermbg=none  cterm=underline
hi SpellLocal        ctermfg=13    ctermbg=none  cterm=underline
hi SpellRare         ctermfg=14    ctermbg=none  cterm=underline
hi Error             ctermfg=none  ctermbg=none  cterm=none
hi Directory         ctermfg=none  ctermbg=none  cterm=none
hi Conceal           ctermfg=8     ctermbg=none  cterm=none
hi Invisible         ctermfg=8     ctermbg=none  cterm=none
hi NonText           ctermfg=8     ctermbg=none  cterm=none
hi SpecialKey        ctermfg=8     ctermbg=none  cterm=none
hi QuickFixLine      ctermfg=none  ctermbg=none  cterm=none
hi WildMenu          ctermfg=none  ctermbg=none  cterm=none
hi diffAdded         ctermfg=10    ctermbg=none  cterm=none
hi diffRemoved       ctermfg=9     ctermbg=none  cterm=none
hi diffLine          ctermfg=8     ctermbg=none  cterm=none
hi diffChanged       ctermfg=none  ctermbg=none  cterm=none
hi diffFile          ctermfg=none  ctermbg=none  cterm=none
hi diffIndexLine     ctermfg=none  ctermbg=none  cterm=none
hi diffNewFile       ctermfg=none  ctermbg=none  cterm=none
hi diffOldFile       ctermfg=none  ctermbg=none  cterm=none
hi diffSubname       ctermfg=none  ctermbg=none  cterm=none
hi DiffAdd           ctermfg=none  ctermbg=22    cterm=none
hi DiffChange        ctermfg=none  ctermbg=22    cterm=none
hi DiffText          ctermfg=none  ctermbg=28    cterm=none
hi DiffDelete        ctermfg=52    ctermbg=none  cterm=reverse

hi! link BashStatement Normal
hi! link shCommandSub Normal
hi! link shForPP Normal
hi! link shLoop Statement
hi! link shOption Normal
hi! link shQuote String
hi! link shRange Normal
hi! link shSnglCase Normal
hi! link shStatement Normal
hi! link shTestOpr Normal

hi! link cCommentStartError Comment
hi! link cErrInBracket Normal
hi! link cErrInParen Normal
hi! link cError Normal
hi! link cWrongComTail Comment

hi! link rustModPathSep Normal
hi! link rustCommentLineDoc Comment

hi! link htmlLink Normal
hi! link htmlString Normal
hi! link htmlTagName Normal
hi! link htmlBold Normal
hi! link htmlBoldItalic Normal
hi! link htmlBoldUnderline Normal
hi! link htmlBoldItalicUnderline Normal
hi! link htmlBoldUnderlineItalic Normal
hi! link htmlUnderlineBold Normal
hi! link htmlUnderlineItalicBold Normal
hi! link htmlUnderlineBoldItalic Normal
hi! link htmlItalic Normal
hi! link htmlItalicBold Normal
hi! link htmlItalicBoldUnderline Normal
hi! link htmlItalicUnderlineBold Normal

hi! markdownH1Delimiter ctermfg=11 ctermbg=none cterm=none
hi! link markdownH1 markdownH1Delimiter
hi! link markdownH2Delimiter markdownH1Delimiter
hi! link markdownH2 markdownH1Delimiter
hi! link markdownH3Delimiter markdownH1Delimiter
hi! link markdownH3 markdownH1Delimiter
hi! link markdownH4Delimiter markdownH1Delimiter
hi! link markdownH4 markdownH1Delimiter
hi! link markdownH5Delimiter markdownH1Delimiter
hi! link markdownH5 markdownH1Delimiter
hi! link markdownH6Delimiter markdownH1Delimiter
hi! link markdownH6 markdownH1Delimiter
hi! link markdownAutomaticLink Normal
hi! link markdownBlockquote Normal
hi! link markdownBoldDelimiter Normal
hi! link markdownBoldItalicDelimiter Normal
hi! link markdownBoldItalic Normal
hi! link markdownBold Normal
hi! link markdownCodeBlock Normal
hi! link markdownCodeDelimiter Normal
hi! link markdownCode Normal
hi! link markdownError Normal
hi! link markdownEscape Normal
hi! link markdownFootnoteDefinition Normal
hi! link markdownFootnote Normal
hi! link markdownHeadingDelimiter Normal
hi! link markdownHeadingRule Normal
hi! link markdownIdDeclaration Normal
hi! link markdownIdDelimiter Normal
hi! link markdownId Normal
hi! link markdownItalicDelimiter Normal
hi! link markdownItalicDelimiter Normal
hi! link markdownItalic Normal
hi! link markdownItalic Normal
hi! link markdownLineBreak Normal
hi! link markdownLineStart Normal
hi! link markdownLinkDelimiter Normal
hi! link markdownLink Normal
hi! link markdownLinkTextDelimiter Normal
hi! link markdownLinkText Normal
hi! link markdownListMarker Normal
hi! link markdownOrderedListMarker Normal
hi! link markdownRule Normal
hi! link markdownStrikeDelimiter Normal
hi! link markdownStrike Normal
hi! link markdownUrlDelimiter  Normal
hi! link markdownUrl Normal
hi! link markdownUrlTitleDelimiter Normal
hi! link markdownUrlTitle Normal
hi! link markdownValid Normal
hi! link markdownYamlHead Normal

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
