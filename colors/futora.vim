" Futora
" Francis Tseng (@frnsys)
" ref: <http://vimdoc.sourceforge.net/htmldoc/syntax.html>
" or :h hi

hi Normal       ctermfg=235
hi Visual       ctermbg=227
hi ModeMsg      ctermfg=1
hi ErrorMsg     ctermbg=196 ctermfg=230

hi CursorLine   ctermbg=230 cterm=none
hi CursorLineNr ctermbg=230
hi CursorColumn ctermbg=230
hi ColorColumn  ctermbg=230
hi VertSplit    cterm=none
hi TabLine      ctermbg=252 ctermfg=246 cterm=none
hi TabLineSel   ctermbg=none
hi TabLineFill  cterm=none ctermbg=252

hi PMenu        ctermbg=229 ctermfg=0
hi PMenuSel     cterm=reverse
hi Search       ctermbg=9 ctermfg=230
hi Folded       ctermbg=3 ctermfg=8

hi DiffAdd      ctermfg=42
hi DiffDelete   ctermfg=196
hi DiffChange   ctermfg=61

hi MatchParen   ctermbg=227
hi Comment      ctermfg=8
hi Todo         ctermbg=196 ctermfg=229
hi String       ctermfg=24
hi Function     ctermfg=160
hi Conditional  ctermfg=14
hi Repeat       ctermfg=14
hi Operator     ctermfg=14
hi Include      ctermfg=14
hi Constant     ctermfg=9
hi Define       ctermfg=11
hi Special      ctermfg=8
hi Statement    ctermfg=1
hi Identifier   ctermfg=9
hi Type         ctermfg=9
hi Character    ctermfg=11
hi Number       ctermfg=11
hi Boolean      ctermfg=11
hi Float        ctermfg=11
hi Error        ctermbg=160 ctermfg=160

hi Title        ctermfg=1
hi PreProc      ctermfg=14
hi SpellCap     ctermfg=none ctermbg=none cterm=underline
hi SpellBad     ctermfg=none ctermbg=none cterm=underline

" TODO unsure
hi Keyword      ctermbg=33
hi Conceal      ctermbg=33
hi Structure    ctermbg=33
hi Ignore       ctermbg=33
hi WarningMsg   ctermbg=196

" markdown
" ref: <https://github.com/tpope/vim-markdown/blob/master/syntax/markdown.vim>
hi markdownCheckboxUnchecked  ctermfg=196
hi markdownCheckboxChecked    ctermfg=35
hi markdownUnchecked          ctermfg=none
hi markdownChecked            ctermfg=3
hi markdownEqnIn              ctermfg=4
hi markdownEqnDelimiter       ctermfg=42
hi markdownCode               ctermfg=4
hi markdownCodeDelimiter      ctermfg=42
hi markdownCodeBlock          ctermfg=4
hi markdownBold               ctermfg=42 ctermbg=none
hi markdownItalic             ctermfg=42 ctermbg=none
hi markdownUrl                ctermfg=2
