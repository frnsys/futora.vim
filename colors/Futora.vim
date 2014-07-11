" Futora
" Francis Tseng (@frnsys)
" Based off of Tomorrow Night (http://chriskempson.com)

" Default GUI Colours
let s:foreground = "c5c8c6"
let s:background = "202020"
let s:selection = "373b41"
let s:line = "282a2e"
let s:comment = "969896"
let s:red = "F33B23"
let s:yellow = "FAB72E"
let s:green = "4BF79F"
let s:aqua = "34BFAC"
let s:blue = "33CDFD"
let s:darkblue = "0c94bf"
let s:purple = "9D69E9"
let s:window = "262626"
let s:gray = "686868"
let s:lightgray = "999999"
let s:darkgray = "585858"
let s:highlight = "585858"

" Console 256 Colours
if !has("gui_running")
    let s:background = "202020"
	let s:window = "5e5e5e"
	let s:line = "3a3a3a"
	let s:selection = "585858"
end

" Light variation
if &background == "light"
    let s:foreground = "2a2a2a"
    let s:background = "fcfaf8"
    let s:highlight = "dddddd"
    let s:selection = "eaeaea"
    let s:line = "eeeeee"
    let s:comment = "666666"
    let s:purple = "994DFB"
    let s:blue = "2598f9"
    let s:aqua = "00AAAA"
    let s:lightgray = "9ABDC8"
    let s:green = "39D369"
    let s:yellow = "F5871F"
endif
hi clear
syntax reset

let g:colors_name = "Futora"

if has("gui_running") || &t_Co == 88 || &t_Co == 256
	" Returns an approximate grey index for the given grey level
	fun <SID>grey_number(x)
		if &t_Co == 88
			if a:x < 23
				return 0
			elseif a:x < 69
				return 1
			elseif a:x < 103
				return 2
			elseif a:x < 127
				return 3
			elseif a:x < 150
				return 4
			elseif a:x < 173
				return 5
			elseif a:x < 196
				return 6
			elseif a:x < 219
				return 7
			elseif a:x < 243
				return 8
			else
				return 9
			endif
		else
			if a:x < 14
				return 0
			else
				let l:n = (a:x - 8) / 10
				let l:m = (a:x - 8) % 10
				if l:m < 5
					return l:n
				else
					return l:n + 1
				endif
			endif
		endif
	endfun

	" Returns the actual grey level represented by the grey index
	fun <SID>grey_level(n)
		if &t_Co == 88
			if a:n == 0
				return 0
			elseif a:n == 1
				return 46
			elseif a:n == 2
				return 92
			elseif a:n == 3
				return 115
			elseif a:n == 4
				return 139
			elseif a:n == 5
				return 162
			elseif a:n == 6
				return 185
			elseif a:n == 7
				return 208
			elseif a:n == 8
				return 231
			else
				return 255
			endif
		else
			if a:n == 0
				return 0
			else
				return 8 + (a:n * 10)
			endif
		endif
	endfun

	" Returns the palette index for the given grey index
	fun <SID>grey_colour(n)
		if &t_Co == 88
			if a:n == 0
				return 16
			elseif a:n == 9
				return 79
			else
				return 79 + a:n
			endif
		else
			if a:n == 0
				return 16
			elseif a:n == 25
				return 231
			else
				return 231 + a:n
			endif
		endif
	endfun

	" Returns an approximate colour index for the given colour level
	fun <SID>rgb_number(x)
		if &t_Co == 88
			if a:x < 69
				return 0
			elseif a:x < 172
				return 1
			elseif a:x < 230
				return 2
			else
				return 3
			endif
		else
			if a:x < 75
				return 0
			else
				let l:n = (a:x - 55) / 40
				let l:m = (a:x - 55) % 40
				if l:m < 20
					return l:n
				else
					return l:n + 1
				endif
			endif
		endif
	endfun

	" Returns the actual colour level for the given colour index
	fun <SID>rgb_level(n)
		if &t_Co == 88
			if a:n == 0
				return 0
			elseif a:n == 1
				return 139
			elseif a:n == 2
				return 205
			else
				return 255
			endif
		else
			if a:n == 0
				return 0
			else
				return 55 + (a:n * 40)
			endif
		endif
	endfun

	" Returns the palette index for the given R/G/B colour indices
	fun <SID>rgb_colour(x, y, z)
		if &t_Co == 88
			return 16 + (a:x * 16) + (a:y * 4) + a:z
		else
			return 16 + (a:x * 36) + (a:y * 6) + a:z
		endif
	endfun

	" Returns the palette index to approximate the given R/G/B colour levels
	fun <SID>colour(r, g, b)
		" Get the closest grey
		let l:gx = <SID>grey_number(a:r)
		let l:gy = <SID>grey_number(a:g)
		let l:gz = <SID>grey_number(a:b)

		" Get the closest colour
		let l:x = <SID>rgb_number(a:r)
		let l:y = <SID>rgb_number(a:g)
		let l:z = <SID>rgb_number(a:b)

		if l:gx == l:gy && l:gy == l:gz
			" There are two possibilities
			let l:dgr = <SID>grey_level(l:gx) - a:r
			let l:dgg = <SID>grey_level(l:gy) - a:g
			let l:dgb = <SID>grey_level(l:gz) - a:b
			let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
			let l:dr = <SID>rgb_level(l:gx) - a:r
			let l:dg = <SID>rgb_level(l:gy) - a:g
			let l:db = <SID>rgb_level(l:gz) - a:b
			let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
			if l:dgrey < l:drgb
				" Use the grey
				return <SID>grey_colour(l:gx)
			else
				" Use the colour
				return <SID>rgb_colour(l:x, l:y, l:z)
			endif
		else
			" Only one possibility
			return <SID>rgb_colour(l:x, l:y, l:z)
		endif
	endfun

	" Returns the palette index to approximate the 'rrggbb' hex string
	fun <SID>rgb(rgb)
		let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
		let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
		let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0

		return <SID>colour(l:r, l:g, l:b)
	endfun

	" Sets the highlighting for the given group
	fun <SID>X(group, fg, bg, attr)
		if a:fg != ""
			exec "hi " . a:group . " guifg=#" . a:fg . " ctermfg=" . <SID>rgb(a:fg)
		endif
		if a:bg != ""
			exec "hi " . a:group . " guibg=#" . a:bg . " ctermbg=" . <SID>rgb(a:bg)
		endif
		if a:attr != ""
			exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
		endif
	endfun

	" Vim Highlighting
	call <SID>X("Normal", s:foreground, s:background, "")
	call <SID>X("LineNr", s:gray, s:highlight, "bold")
	call <SID>X("NonText", s:selection, "", "")
	call <SID>X("SpecialKey", s:selection, "", "")
	call <SID>X("Search", s:background, s:yellow, "")
	call <SID>X("TabLine", s:foreground, s:background, "reverse")
	call <SID>X("StatusLine", s:window, s:yellow, "reverse")
	call <SID>X("StatusLineNC", s:window, s:foreground, "reverse")
	call <SID>X("VertSplit", s:window, s:window, "none")
	call <SID>X("Visual", "", s:selection, "")
	call <SID>X("Directory", s:blue, "", "")
	call <SID>X("ModeMsg", s:green, "", "")
	call <SID>X("MoreMsg", s:green, "", "")
	call <SID>X("Question", s:green, "", "")
	call <SID>X("WarningMsg", s:red, "", "")
	call <SID>X("MatchParen", "", s:selection, "")
	call <SID>X("Folded", s:comment, s:background, "")
	call <SID>X("FoldColumn", "", s:background, "")
	if version >= 700
		call <SID>X("CursorLine", "", s:line, "none")
		call <SID>X("CursorLineNr", s:background, s:purple, "none")
		call <SID>X("CursorColumn", "", s:line, "none")
		call <SID>X("PMenu", s:foreground, s:selection, "none")
		call <SID>X("PMenuSel", s:foreground, s:selection, "reverse")
		call <SID>X("SignColumn", "", s:background, "none")
	end
	if version >= 703
		call <SID>X("ColorColumn", "", s:line, "none")
	end

	" Standard Highlighting
	call <SID>X("Comment", s:comment, s:highlight, "")
	call <SID>X("Todo", s:comment, s:background, "")
	call <SID>X("Title", s:comment, "", "")
	call <SID>X("Identifier", s:red, "", "none")
	call <SID>X("Statement", s:foreground, "", "")
	call <SID>X("Conditional", s:foreground, "", "")
	call <SID>X("Repeat", s:foreground, "", "")
	call <SID>X("Structure", s:purple, "", "")
	call <SID>X("Function", s:blue, "", "")
	call <SID>X("Constant", s:purple, "", "")
	call <SID>X("String", s:aqua, "", "")
	call <SID>X("Special", s:foreground, "", "")
	call <SID>X("PreProc", s:purple, "", "")
	call <SID>X("Operator", s:red, "", "none")
	call <SID>X("Type", s:blue, "", "none")
	call <SID>X("Define", s:purple, "", "none")
	call <SID>X("Include", s:blue, "", "")
	call <SID>X("Conceal", s:purple, s:background, "")
	"call <SID>X("Ignore", "666666", "", "")

	" Vim Highlighting
	call <SID>X("vimCommand", s:blue, "", "none")

	" Markdown Highlighting
	call <SID>X("markdownH1", s:red, "", "none")
	call <SID>X("markdownH2", s:red, "", "none")
	call <SID>X("markdownHeadingRule", s:red, "", "none")
	call <SID>X("markdownListMarker", s:red, "", "none")
	call <SID>X("markdownOrderedListMarker", s:red, "", "none")
	call <SID>X("markdownHeadingRule", s:aqua, "", "none")
	call <SID>X("markdownBold", s:red, "", "bold")
	call <SID>X("markdownItalic", s:purple, "", "underline")
    call <SID>X("markdownBlockquote", s:blue, "", "none")
    call <SID>X("markdownUrl", s:purple, "", "none")
    call <SID>X("markdownId", s:red, "", "none")
    call <SID>X("markdownIdDeclaration", s:red, "", "none")
    call <SID>X("markdownLinkText", s:blue, "", "underline")
    call <SID>X("markdownUrlTitle", s:blue, "", "none")
    call <SID>X("markdownCode", s:lightgray, "", "none")
    call <SID>X("markdownFootnote", s:purple, "", "none")
    call <SID>X("markdownFootnoteDefinition", s:gray, "", "none")

	" C Highlighting
	call <SID>X("cType", s:yellow, "", "")
	call <SID>X("cStorageClass", s:purple, "", "")
	call <SID>X("cConditional", s:purple, "", "")
	call <SID>X("cRepeat", s:purple, "", "")

	" C# Highlighting
	call <SID>X("csType", s:yellow, "", "")
	call <SID>X("csModifier", s:yellow, "", "")
	call <SID>X("csUnspecifiedStatement", s:yellow, "", "")
	call <SID>X("csException", s:red, "", "")
	call <SID>X("csLinqKeyword", s:red, "", "")
	call <SID>X("csStorage", s:red, "", "")
	call <SID>X("csRepeat", s:red, "", "")
	call <SID>X("csConditional", s:red, "", "")
	call <SID>X("csLabel", s:red, "", "")
	call <SID>X("csClass", s:green, "", "")
	call <SID>X("csConstant", s:purple, "", "")

	" PHP Highlighting
	call <SID>X("phpVarSelector", s:red, "", "")
	call <SID>X("phpKeyword", s:purple, "", "")
	call <SID>X("phpRepeat", s:purple, "", "")
	call <SID>X("phpConditional", s:purple, "", "")
	call <SID>X("phpStatement", s:purple, "", "")
	call <SID>X("phpMemberSelector", s:foreground, "", "")

	" Ruby Highlighting
	call <SID>X("rubySymbol", s:green, "", "")
	call <SID>X("rubyConstant", s:yellow, "", "")
	call <SID>X("rubyAttribute", s:blue, "", "")
	call <SID>X("rubyInclude", s:blue, "", "")
	call <SID>X("rubyLocalVariableOrMethod", s:purple, "", "")
	call <SID>X("rubyCurlyBlock", s:purple, "", "")
	call <SID>X("rubyStringDelimiter", s:green, "", "")
	call <SID>X("rubyInterpolationDelimiter", s:purple, "", "")
	call <SID>X("rubyConditional", s:purple, "", "")
	call <SID>X("rubyRepeat", s:purple, "", "")

	" Python Highlighting
	call <SID>X("pythonInclude", s:purple, "", "")
	call <SID>X("pythonPreCondit", s:red, "", "")
	call <SID>X("pythonStatement", s:purple, "", "")
	call <SID>X("pythonConditional", s:red, "", "")
	call <SID>X("pythonOperator", s:red, "", "")
	call <SID>X("pythonRepeat", s:red, "", "")
	call <SID>X("pythonException", s:purple, "", "")
	call <SID>X("pythonDefinition", s:darkgray, "", "")
	call <SID>X("pythonFunction", s:yellow, "", "")
	call <SID>X("pythonNumber", s:yellow, "", "")
	call <SID>X("pythonBoolean", s:yellow, "", "")

    " Scala Highlighting
    call <SID>X("scalaKeyword", s:red, "", "")
    call <SID>X("scalaKeywordModifier", s:red, "", "")
    call <SID>X("scalaType", s:purple, "", "")
    call <SID>X("scalaOperator", s:purple, "", "")
    call <SID>X("scalaDef", s:darkgray, "", "")
    call <SID>X("scalaVar", s:darkgray, "", "")
    call <SID>X("scalaVal", s:darkgray, "", "")
    call <SID>X("scalaClass", s:darkgray, "", "")
    call <SID>X("scalaObject", s:darkgray, "", "")
    call <SID>X("scalaTrait", s:darkgray, "", "")
    call <SID>X("scalaDefName", s:yellow, "", "")
    call <SID>X("scalaValName", s:yellow, "", "")
    call <SID>X("scalaVarName", s:yellow, "", "")
    call <SID>X("scalaClassName", s:yellow, "", "")
    call <SID>X("scalaDefSpecializer", s:yellow, "", "")
    call <SID>X("scalaClassSpecializer", s:yellow, "", "")
    call <SID>X("scalaBackTick", s:yellow, "", "")
    call <SID>X("scalaPackage", s:red, "", "")
    call <SID>X("scalaImport", s:green, "", "")
    call <SID>X("scalaBoolean", s:yellow, "", "")

	" JavaScript Highlighting
	call <SID>X("javaScriptBraces", s:red, "", "")
	call <SID>X("javaScriptFunction", s:purple, "", "")
	call <SID>X("javaScriptConditional", s:purple, "", "")
	call <SID>X("javaScriptRepeat", s:red, "", "")
	call <SID>X("javaScriptNumber", s:yellow, "", "")
	call <SID>X("javaScriptMember", s:purple, "", "")
	call <SID>X("jsExceptions", s:red, "", "")
	call <SID>X("jsBuiltins", s:red, "", "")
	call <SID>X("jsException", s:yellow, "", "")
	call <SID>X("jsKeyword", s:yellow, "", "")
	call <SID>X("jsStatement", s:yellow, "", "")
	call <SID>X("jsBoolean", s:yellow, "", "")
	call <SID>X("jsNumber", s:yellow, "", "")
	call <SID>X("jsFloat", s:yellow, "", "")
	call <SID>X("jsFunction", s:purple, "", "")
	call <SID>X("jsType", s:darkgray, "", "")
	call <SID>X("jsThis", s:darkgray, "", "")
	call <SID>X("jsRepeat", s:red, "", "")
	call <SID>X("jsNull", s:red, "", "")
	call <SID>X("jsReturn", s:red, "", "")
	call <SID>X("jsConditional", s:red, "", "")
	call <SID>X("jsCommentTodo", s:red, "", "")
	call <SID>X("jsOperator", s:red, "", "")
    call <SID>X("jsLabel", s:red, "", "")
	call <SID>X("jsGlobalObjects", s:yellow, "", "")
	call <SID>X("jsHtmlEvents", s:purple, "", "")
	call <SID>X("jsCssStyles", s:purple, "", "")

	" HTML Highlighting
	call <SID>X("htmlTag", s:gray, "", "")
	call <SID>X("htmlEndTag", s:gray, "", "")
	call <SID>X("htmlTagName", s:blue, "", "")
	call <SID>X("htmlArg", s:darkblue, "", "")
	call <SID>X("htmlScriptTag", s:red, "", "")

    " (S)CSS Highlighting
	call <SID>X("cssPositioningAttr", s:aqua, "", "")
	call <SID>X("cssUIAttr", s:aqua, "", "")
	call <SID>X("cssFlexibleBoxAttr", s:aqua, "", "")
	call <SID>X("cssTextAttr", s:aqua, "", "")
	call <SID>X("cssFontAttr", s:aqua, "", "")
	call <SID>X("cssBorderOutlineAttr", s:aqua, "", "")
	call <SID>X("cssCommonAttr", s:aqua, "", "")
	call <SID>X("cssBoxAttr", s:aqua, "", "")
	call <SID>X("cssAuralAttr", s:aqua, "", "")
	call <SID>X("cssColor", s:yellow, "", "")

	" Diff Highlighting
	call <SID>X("diffAdded", s:green, "", "")
	call <SID>X("diffRemoved", s:red, "", "")

    " ShowMarks Highlighting
    call <SID>X("ShowMarksHLl", s:purple, s:background, "none")
    call <SID>X("ShowMarksHLo", s:purple, s:background, "none")
    call <SID>X("ShowMarksHLu", s:yellow, s:background, "none")
    call <SID>X("ShowMarksHLm", s:aqua, s:background, "none")

	" Delete Functions
	delf <SID>X
	delf <SID>rgb
	delf <SID>colour
	delf <SID>rgb_colour
	delf <SID>rgb_level
	delf <SID>rgb_number
	delf <SID>grey_colour
	delf <SID>grey_level
	delf <SID>grey_number
endif
