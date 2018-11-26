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
let g:colors_name= 'joker'

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
let s:colors.base_8 = {'gui': '#9064d1', 'cterm': 98} " Identifier

" Other colors
let s:colors.red = {'gui': '#d12c34', 'cterm': 167}
let s:colors.blue = {'gui': '#6e83a8', 'cterm': 67}
let s:colors.darkblue = {'gui': '#0d1724', 'cterm': 235}
let s:colors.darkgray = {'gui': '#adadad', 'cterm': 145}
let s:colors.darkgreen = {'gui': '#211f1a', 'cterm': 234}
let s:colors.lightgray = {'gui': '#acb0b5', 'cterm': 249}
let s:colors.lightpurple = {'gui': '#c8acff', 'cterm': 183}
let s:colors.purple = {'gui': '#444675', 'cterm': 60}
let s:colors.yellow = {'gui': '#b6bd84', 'cterm': 144}
let s:colors.black = {'gui': '#000000', 'cterm' None}

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
call s:Col('Visual', '', 'base_7')

" Easy-to-guess code elements.
call s:Col('Comment', 'purple')
call s:Col('String', 'darkgray')
call s:Col('Number', 'red')
call s:Col('Statement', 'base_2')
call s:Col('Special', 'base_7')
call s:Col('Identifier', 'base5')

" Constants, Ruby symbols.
call s:Col('Constant', 'blue')

" Some HTML tags (<title>, some <h*>s)
call s:Col('Title', 'yellow')

" <a> tags.
call s:Col('Underlined', 'yellow')
call s:Attr('Underlined', 'underline')

" Types, HTML attributes, Ruby constants (and class names).
call s:Col('Type', 'base_2')

" Stuff like 'require' in Ruby.
call s:Col('PreProc', 'red')

" Tildes on the bottom of the page.
call s:Col('NonText', 'base_7')

" " Concealed stuff.
" call s:Col('Conceal', 'cyan', s:background)

" TODO and similar tags.
call s:Col('Todo', 'yellow', s:background)

" The column separating vertical splits.
call s:Col('VertSplit', 'base_3', s:linenr_background)
call s:Col('StatusLineNC', 'base_3', 'base2')

" Matching parenthesis.
call s:Col('MatchParen', 'yellow', 'orange')

" Special keys, e.g. some of the chars in 'listchars'. See ':h listchars'.
call s:Col('SpecialKey', 'base_7')

" Folds.
call s:Col('Folded', 'darkblue', 'blue')
call s:Col('FoldColumn', 'darkblue', 'blue')

" Searching.
call s:Col('Search', 'darkblue', 'yellow')
call s:Attr('IncSearch', 'reverse')

" Popup menu.
call s:Col('Pmenu', 'lightgray', 'darkgreen')
call s:Col('PmenuSel', 'darkblue', 'base_2')
call s:Col('PmenuSbar', '', 'base_5')
call s:Col('PmenuThumb', '', 'black')

" Command line stuff.
call s:Col('ErrorMsg', 'red', 'base_0')
call s:Col('Error', 'red', 'base_0')
call s:Col('ModeMsg', 'blue')
call s:Col('WarningMsg', 'red')

" Wild menu.
" StatusLine determines the color of the non-active entries in the wild menu.
call s:Col('StatusLine', 'base_1', 'base_4')
call s:Col('WildMenu', 'darkblue', 'blue')

" Tab line.
call s:Col('TabLineSel', 'lightgray', 'base_4')  " the selected tab
call s:Col('TabLine', '', 'darkgreen')     " the non-selected tabs
call s:Col('TabLineFill', 'base_0', 'base_0') " the rest of the tab line

" Spelling.
call s:Col('SpellBad', 'lightpurple', 'darkblue')
call s:Col('SpellCap', 'lightpurple', 'darkblue')
call s:Col('SpellLocal', 'lightpurple')
call s:Col('SpellRare', 'lightpurple', 'darkblue')

" Diffing.
call s:Col('DiffAdd', 'lightgray', 'darkgreen')
call s:Col('DiffChange', 'lightgray', 'blue')
call s:Col('DiffDelete', 'lightgray', 'red')
call s:Col('DiffText', 'lightgray', 'darkgreen')
call s:Col('DiffAdded', 'darkgreen')
call s:Col('DiffChanged', 'blue')
call s:Col('DiffRemoved', 'red')
call s:Col('DiffSubname', 'blue')

" Directories (e.g. netrw).
call s:Col('Directory', 'darkgreen')


" Programming languages and filetypes ==========================================

" Ruby.
call s:Col('rubyDefine', 'blue')
call s:Col('rubyStringDelimiter', 'green')

" HTML (and often Markdown).
call s:Col('htmlArg', 'blue')
call s:Col('htmlItalic', 'red')
call s:Col('htmlBold', 'yellow', '')

" Python
call s:Col('pythonStatement', 'blue')


" Plugin =======================================================================
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
