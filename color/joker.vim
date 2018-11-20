"                 __        __
"                |__| ____ |  | __ ___________
"                |  |/  _ \|  |/ // __ \_  __ \
"                |  (  <_> )    <\  ___/|  | \/
"            /\__|  |\____/|__|_ \\___  >__|
"            \______|           \/    \/
"

"============ Syntax ================="
hi clear
if exists("syntax_on")
	syntax reset
endif

set background=dark
let colors_name="joker"

"============= Helper Functions ============"
" Based on vim-gotham

function! s:Highlight(args)
  exec 'highlight ' . join(a:args, ' ')
endfunction

function! s:AddGroundValues(accumulator, ground, color)
	let new_list = a:accumulator
	for [platform, value] in items(a:color)
		call add(a:new_list, platform . a:ground . '=' . value)
	endfor

	return new_list
endfunction

" Set Ground colors
function! s:Col(group, fg_col, bg_col, sp_col)

  let pieces = [a:group]

  if a:fg_col !=# ''
    let pieces = s:AddGroundValues(pieces, 'fg', s:colors[a:fg_col])
  endif

  if a:bg_col !=# ''
    let pieces = s:AddGroundValues(pieces, 'bg', s:colors[a:bg_col])
  endif

	if a:sp_col !=# ''
		let pieces = s:AddGroundValues(pieces, 'sp', s:colors[a:sp_col])
	endif

  call s:Clear(a:group)
  call s:Highlight(pieces)
endfunction

function! s:Attr(group, attr)
  let l:attrs = [a:group, 'term=' . a:attr, 'cterm=' . a:attr, 'gui=' . a:attr]
  call s:Highlight(l:attrs)
endfunction

function! s:Clear(group)
  exec 'highlight clear ' . a:group
endfunction


"============= Colors ===================="
" Store all the colors in a dictionary
let s:colors = {}

" Base colors
let s:colors.base_0 = {'gui': '#000310', 'cterm': 17} " bg
let s:colors.base_1 = {'gui': '#ffffff', 'cterm': 15} " fg
let s:colors.base_2 = {'gui': '#2d8f1a', 'cterm': 28} " statement
let s:colors.base_3 = {'gui': '#315099', 'cterm': 67} " function
let s:colors.base_4 = {'gui': '#282b26', 'cterm': 235} " line bg
let s:colors.base_5 = {'gui': '#6b6b6b', 'cterm': 242} " line fg
let s:colors.base_6 = {'gui': '#0f1f07', 'cterm': 22} " status line
let s:colors.base_7 = {'gui': '#3d5570', 'cterm': 60} " special key

" Other colors
let s:colors.red = {'gui': '#d13b33', 'cterm': 167}
let s:colors.blue = {'gui': '#6e83a8', 'cterm': 67}
let s:colors.darkgray = {'gui': '#adadad', 'cterm': 145}
let s:colors.lightgray = {'gui': '#acb0b5', 'cterm': 249}
let s:colors.purple = {'gui': '#444675', 'cterm': 60}
let s:colors.yellow = {'gui': '#b6bd84', 'cterm': 144}

" No colors
let s:colors.null = {'gui': 'NONE', 'cterm': 'NONE'}

" Native highlighting ==========================================================

let s:background = 'base_0'
let s:linenr_background = 'base_4'

" Everything starts here.
call s:Col('Normal', 'base_1', s:background)

" Line, cursor and so on.
call s:Col('Cursor', 'base_4', 'base_1')
call s:Col('CursorLine', '', 'base_4')
call s:Col('CursorColumn', '', 'base_4')

" Sign column, line numbers.
call s:Col('LineNr', 'blue', s:linenr_background)
call s:Col('CursorLineNr', 'base5', s:linenr_background)
call s:Col('SignColumn', '', s:linenr_background)
call s:Col('ColorColumn', '', s:linenr_background)

" Visual selection.
call s:Col('Visual', '', 'base3')

" Easy-to-guess code elements.
call s:Col('Comment', 'blue')
call s:Col('String', 'green')
call s:Col('Number', 'orange')
call s:Col('Statement', 'base5')
call s:Col('Special', 'orange')
call s:Col('Identifier', 'base5')

" Constants, Ruby symbols.
call s:Col('Constant', 'magenta')

" Some HTML tags (<title>, some <h*>s)
call s:Col('Title', 'orange')

" <a> tags.
call s:Col('Underlined', 'yellow')
call s:Attr('Underlined', 'underline')

" Types, HTML attributes, Ruby constants (and class names).
call s:Col('Type', 'orange')

" Stuff like 'require' in Ruby.
call s:Col('PreProc', 'red')

" Tildes on the bottom of the page.
call s:Col('NonText', 'blue')

" Concealed stuff.
call s:Col('Conceal', 'cyan', s:background)

" TODO and similar tags.
call s:Col('Todo', 'magenta', s:background)

" The column separating vertical splits.
call s:Col('VertSplit', 'blue', s:linenr_background)
call s:Col('StatusLineNC', 'blue', 'base2')

" Matching parenthesis.
call s:Col('MatchParen', 'base6', 'orange')

" Special keys, e.g. some of the chars in 'listchars'. See ':h listchars'.
call s:Col('SpecialKey', 'base3')

" Folds.
call s:Col('Folded', 'base6', 'blue')
call s:Col('FoldColumn', 'base5', 'base3')

" Searching.
call s:Col('Search', 'base2', 'yellow')
call s:Attr('IncSearch', 'reverse')

" Popup menu.
call s:Col('Pmenu', 'base6', 'base2')
call s:Col('PmenuSel', 'base7', 'blue')
call s:Col('PmenuSbar', '', 'base2')
call s:Col('PmenuThumb', '', 'blue')

" Command line stuff.
call s:Col('ErrorMsg', 'red', 'base1')
call s:Col('Error', 'red', 'base1')
call s:Col('ModeMsg', 'blue')
call s:Col('WarningMsg', 'red')

" Wild menu.
" StatusLine determines the color of the non-active entries in the wild menu.
call s:Col('StatusLine', 'base5', 'base2')
call s:Col('WildMenu', 'base7', 'cyan')

" The 'Hit ENTER to continue prompt'.
call s:Col('Question', 'green')

" Tab line.
call s:Col('TabLineSel', 'base7', 'blue')  " the selected tab
call s:Col('TabLine', 'base6', 'base2')     " the non-selected tabs
call s:Col('TabLineFill', 'base0', 'base0') " the rest of the tab line

" Spelling.
call s:Col('SpellBad', 'base7', 'red')
call s:Col('SpellCap', 'base7', 'blue')
call s:Col('SpellLocal', 'yellow')
call s:Col('SpellRare', 'base7', 'violet')

" Diffing.
call s:Col('DiffAdd', 'base7', 'green')
call s:Col('DiffChange', 'base7', 'blue')
call s:Col('DiffDelete', 'base7', 'red')
call s:Col('DiffText', 'base7', 'cyan')
call s:Col('DiffAdded', 'green')
call s:Col('DiffChanged', 'blue')
call s:Col('DiffRemoved', 'red')
call s:Col('DiffSubname', 'blue')

" Directories (e.g. netrw).
call s:Col('Directory', 'cyan')


" Programming languages and filetypes ==========================================

" Ruby.
call s:Col('rubyDefine', 'blue')
call s:Col('rubyStringDelimiter', 'green')

" HTML (and often Markdown).
call s:Col('htmlArg', 'blue')
call s:Col('htmlItalic', 'magenta')
call s:Col('htmlBold', 'cyan', '')

" Python
call s:Col('pythonStatement', 'blue')


" Plugin =======================================================================

" GitGutter
call s:Col('GitGutterAdd', 'green', s:linenr_background)
call s:Col('GitGutterChange', 'cyan', s:linenr_background)
call s:Col('GitGutterDelete', 'orange', s:linenr_background)
call s:Col('GitGutterChangeDelete', 'magenta', s:linenr_background)

" CtrlP
call s:Col('CtrlPNoEntries', 'base7', 'orange') " no entries
call s:Col('CtrlPMatch', 'green')               " matching part
call s:Col('CtrlPPrtBase', 'blue')             " '>>>' prompt
call s:Col('CtrlPPrtText', 'cyan')              " text in the prompt
call s:Col('CtrlPPtrCursor', 'base7')           " cursor in the prompt

" unite.vim
call s:Col('UniteGrep', 'base7', 'green')
let g:unite_source_grep_search_word_highlight = 'UniteGrep'

" ale https://github.com/w0rp/ale
call s:Col('ALEWarningSign', 'yellow', s:linenr_background)
call s:Col('ALEErrorSign', 'red', s:linenr_background)

" neomake https://github.com/neomake/neomake
call s:Col('NeomakeWarningSign', 'yellow', s:linenr_background)
call s:Col('NeomakeErrorSign', 'red', s:linenr_background)
call s:Col('NeomakeWarning', 'yellow')
call s:Col('NeomakeError', 'red')

" Cleanup =====================================================================

unlet s:colors
unlet s:background
unlet s:linenr_background
