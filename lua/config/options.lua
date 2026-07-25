local host = require("config.host")

-- ASCII code of the letter Aleph (Hebrew)
--vim.opt.aleph

-- allow CTRL-_ in Insert mode
vim.opt.allowrevins = false

-- what to do with Unicode chars of ambiguous width
local ambiwidth
ambiwidth = "single"
ambiwidth = "double"
--vim.opt.ambiwidth = ambiwidth

-- for Arabic as a default second language
vim.opt.arabic = false

-- do shaping for Arabic characters
vim.opt.arabicshape = true

-- change directory to the file in the current window
vim.opt.autochdir = false

-- enable automatic completion in insert mode
vim.opt.autocomplete = false

-- delay in msec before menu appears after typing
---@type number msecs
vim.opt.autocompletedelay = 0

-- initial decay timeout for autocompletion algorithm
---@type number msecs
vim.opt.autocompletetimeout = 80

-- take indent for new line from previous line
vim.opt.autoindent = true

-- autom. read file when changed outside of Vim
vim.opt.autoread = true

-- automatically write file if changed
vim.opt.autowrite = false

-- as 'autowrite', but works with more commands
vim.opt.autowriteall = false

-- "dark" or "light", used for highlight colors
vim.opt.background = "dark"

-- how backspace works at start of line
vim.opt.backspace = "indent,eol,start"

-- keep backup file after overwriting a file
vim.opt.backup = false

-- make backup as a copy, don't rename the file
vim.opt.backupcopy = "auto"

-- list of directories for the backup file
-- https://neovim.io/doc/user/options/#'backupdir'
--vim.opt.backupdir

-- extension used for the backup file
vim.opt.backupext = "~"

-- no backup for files that match these patterns
vim.opt.backupskip = "/tmp/*"

-- do not ring the bell for these reasons
vim.opt.belloff = "all"

-- read/write/edit file in binary mode
vim.opt.binary = false

-- prepend a Byte Order Mark to the file
vim.opt.bomb = false

-- characters that may cause a line break
vim.opt.breakat = " \9!@*-+;:,./?"

-- wrapped line repeats indent
vim.opt.breakindent = false

-- settings for 'breakindent'
-- https://neovim.io/doc/user/options/#'breakindentopt'
--vim.opt.breakindentopt

-- XXX: removed?

-- which directory to start browsing in
--vim.opt.browsedir

-- what to do when buffer is no longer in window
-- https://neovim.io/doc/user/options/#'bufhidden'
--vim.opt.bufhidden

-- whether the buffer shows up in the buffer list
vim.opt.buflisted = true

-- special type of buffer
-- https://neovim.io/doc/user/options/#'buftype'
--vim.opt.buftype

-- XXX: not documented

-- https://neovim.io/doc/user/options/#'busy'
--vim.opt.busy = 0

-- specifies how case of letters is changed
vim.opt.casemap = "internal,keepascii"

-- change directory to the home directory by ":cd"
vim.opt.cdhome = true

-- list of directories searched with ":cd"
vim.opt.cdpath = ",,"

-- key used to open the command-line window
vim.opt.cedit = "\6"

-- XXX: not documented

-- https://neovim.io/doc/user/options/#'channel'
--vim.opt.channel

-- expression for character encoding conversion
-- https://neovim.io/doc/user/options/#'charconvert'
--vim.opt.charconvert

-- maximum number of quickfix lists in history
vim.opt.chistory = 10

-- do C program indenting
vim.opt.cindent = false

-- keys that trigger indent when 'cindent' is set
vim.opt.cinkeys = "0{,0},0),0],:,0#,!^F,o,O,e"

-- how to do indenting when 'cindent' is set
-- https://neovim.io/doc/user/options/#'cinoptions'
--vim.opt.cinoptions

-- words that are recognized by 'cino-g'
vim.opt.cinscopedecls = "public,protected,private"

-- words where 'si' and 'cin' add an indent
vim.opt.cinwords = "if,else,while,do,for,switch"

-- use the clipboard as the unnamed register
-- TODO: look it: https://neovim.io/doc/user/options/#'clipboard'
vim.opt.clipboard = "unnamedplus"

-- number of lines to use for the command-line
vim.opt.cmdheight = 1

-- height of the command-line window
vim.opt.cmdwinheight = 7

-- columns to highlight
-- https://neovim.io/doc/user/options/#''
--vim.opt.colorcolumn

-- number of columns in the display
--vim.opt.columns

-- patterns that can start a comment line
vim.opt.comments = "s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-,fb:•"

-- template for comments; used for fold marker
--vim.opt.commentstring

-- behave Vi-compatible as much as possible
--vim.opt.compatible

-- specify how Insert mode completion works
vim.opt.complete = ".,w,b,u,t"

-- function to be used for Insert mode completion
--vim.opt.completefunc

-- order of columns in the completion popup
vim.opt.completeitemalign = "abbr,kind,menu"

-- options for Insert mode completion
vim.opt.completeopt = "menu,popup"

-- like 'shellslash' for completion
--vim.opt.completeslash

-- initial decay timeout for CTRL-N and CTRL-P
vim.opt.completetimeout = 0

-- whether concealable text is hidden in cursor line
--vim.opt.concealcursor

-- whether concealable text is shown or hidden
vim.opt.conceallevel = 0

-- ask what to do about unsaved/read-only files
vim.opt.confirm = false

-- make 'autoindent' use existing indent structure
vim.opt.copyindent = false

-- flags for Vi-compatible behavior
vim.opt.cpoptions = "aABceFs_"

-- move cursor in window as it moves in other windows
vim.opt.cursorbind = false

-- highlight the screen column of the cursor
vim.opt.cursorcolumn = false

-- highlight the screen line of the cursor
vim.opt.cursorline = false

-- settings for 'cursorline'
vim.opt.cursorlineopt = "both"

-- set to "msg" to see all error messages
--vim.opt.debug

-- pattern to be used to find a macro definition
--vim.opt.define

-- delete combining characters on their own
vim.opt.delcombine = false

-- list of file names used for keyword completion
--vim.opt.dictionary

-- use diff mode for the current window
vim.opt.diff = false

-- list of {address} to force anchoring of a diff
--vim.opt.diffanchors

-- expression used to obtain a diff file
--vim.opt.diffexpr

-- options for using diff mode
vim.opt.diffopt = "internal,filler,closeoff,indent-heuristic,inline:char,linematch:40"

-- enable the entering of digraphs in Insert mode
vim.opt.digraph = false

-- list of directory names for the swap file
--vim.opt.directory

-- list of flags for how to display text
vim.opt.display = "lastline"

-- in which direction 'equalalways' works
vim.opt.eadirection = "both"

-- toggle flags of ":substitute" (obsolete)
--vim.opt.edcompatible

-- TODO: it?
vim.opt.emoji = true

-- encoding used internally
vim.opt.encoding = "utf-8"

-- write CTRL-Z at end of the file
vim.opt.endoffile = false

-- write <EOL> for last line in file
vim.opt.endofline = true

-- windows are automatically made the same size
vim.opt.equalalways = true

-- external program to use for "=" command
--vim.opt.equalprg

-- ring the bell for error messages
vim.opt.errorbells = false

-- name of the errorfile for the QuickFix mode
vim.opt.errorfile = "errors.err"

-- description of the lines in the error file
--vim.opt.errorformat

-- autocommand events that are ignored
--vim.opt.eventignore

-- autocommand events that are ignored in a window
--vim.opt.eventignorewin

-- use spaces when <Tab> is inserted
vim.opt.expandtab = true

-- read init files in the current directory
vim.opt.exrc = false

-- file encoding for multibyte text
--vim.opt.fileencoding

-- automatically detected character encodings
vim.opt.fileencodings = {
  "utf-8",
  "cp932",
  "ucs-bombs",
  "euc-jp",
  "ucs-bom",
  "default",
  "latin1",
}

-- file format used for file I/O
vim.opt.fileformat = "unix"

-- automatically detected values for 'fileformat'
vim.opt.fileformats = {
  "unix",
  "dos",
  "mac",
}

-- ignore case when using file names
vim.opt.fileignorecase = false

-- type of file, used for autocommands
--vim.opt.filetype

-- characters to use for displaying special items
--vim.opt.fillchars

-- function to be called for the :find command
--vim.opt.findfunc

-- make sure last line in file has <EOL>
vim.opt.fixendofline = true

-- close a fold when the cursor leaves it
--vim.opt.foldclose

-- width of the column used to indicate folds
vim.opt.foldcolumn = "0"

-- set to display all folds open
vim.opt.foldenable = true

-- expression used when 'foldmethod' is "expr"
vim.opt.foldexpr = "0"

-- ignore lines when 'foldmethod' is "indent"
vim.opt.foldignore = "#"

-- close folds with a level higher than this
vim.opt.foldlevel = 0

-- 'foldlevel' when starting to edit a file
vim.opt.foldlevelstart = -1

-- markers used when 'foldmethod' is "marker"
vim.opt.foldmarker = "{{{,}}}"

-- folding type
vim.opt.foldmethod = "manual"

-- minimum number of lines for a fold to be closed
vim.opt.foldminlines = 1

-- maximum fold depth
vim.opt.foldnestmax = 20

-- for which commands a fold will be opened
vim.opt.foldopen = "block,hor,mark,percent,quickfix,search,tag,undo"

-- expression used to display for a closed fold
vim.opt.foldtext = "foldtext()"

-- expression used with "gq" command
--vim.opt.formatexpr

-- pattern used to recognize a list header
vim.opt.formatlistpat = "^\\s*\\d\\+[\\]:.)}\\t ]\\s*"

-- how automatic formatting is to be done
vim.opt.formatoptions = "tcqj"

-- name of external program used with "gq" command
--vim.opt.formatprg

-- whether to invoke fsync() after file write
vim.opt.fsync = true

-- the ":substitute" flag 'g' is default on
vim.opt.gdefault = false

-- format of 'grepprg' output
vim.opt.grepformat = "%f:%l:%m,%f:%l%m,%f  %l%m"

-- program to use for ":grep"
vim.opt.grepprg = "grep -HIn $* /dev/null"

-- GUI: settings for cursor shape and blinking
--vim.opt.guicursor

-- GUI: Name(s) of font(s) to be used
vim.opt.guifont = "Source Code Pro,DejaVu Sans Mono,Courier New,monospace"

-- list of font names for double-wide characters
--vim.opt.guifontwide

-- GUI: Which components and options are used
--vim.opt.guioptions

-- GUI: custom label for a tab page
--vim.opt.guitablabel

-- GUI: custom tooltip for a tab page
--vim.opt.guitabtooltip

-- full path name of the main help file
--vim.opt.helpfile

-- minimum height of a new help window
vim.opt.helpheight = 20

-- preferred help languages
--vim.opt.helplang

-- don't unload buffer when it is abandoned
if host.is_linux() or host.is_mac() then
  vim.opt.hidden = true
end

-- sets highlighting mode for various occasions
--vim.opt.highlight

-- number of command-lines that are remembered
vim.opt.history = 10000

-- Hebrew keyboard mapping
--vim.opt.hkmap

-- phonetic Hebrew keyboard mapping
--vim.opt.hkmapp

-- highlight matches with last search pattern
vim.opt.hlsearch = true

-- let Vim set the text of the window icon
vim.opt.icon = false

-- string to use for the Vim icon text
--vim.opt.iconstring

-- ignore case in search patterns
vim.opt.ignorecase = true

-- XXX: not documented

-- use IM when starting to edit a command line
vim.opt.imcmdline = false

-- XXX: not documented

-- do not use the IM in any mode
vim.opt.imdisable = false

-- use :lmap or IM in Insert mode
vim.opt.iminsert = 0

-- use :lmap or IM when typing a search pattern
vim.opt.imsearch = -1

-- XXX: not documented

vim.opt.inccommand = "nosplit"

-- pattern to be used to find an include file
--vim.opt.include

-- expression used to process an include line
--vim.opt.includeexpr

-- highlight match while typing search pattern
vim.opt.incsearch = true

-- expression used to obtain the indent of a line
--vim.opt.indentexpr

-- keys that trigger indenting with 'indentexpr'
vim.opt.indentkeys = "0{,0},0),0],:,0#,!^F,o,O,e"

-- adjust case of match for keyword completion
vim.opt.infercase = false

-- start the edit of a file in Insert mode (obsolete)
--vim.opt.insertmode

-- characters included in file names and pathnames
vim.opt.isfname = "@,48-57,/,.,-,_,+,,,#,$,%,~,="

-- characters included in identifiers
vim.opt.isident = "@,48-57,_,192-255"

-- characters included in keywords
vim.opt.iskeyword = "@,48-57,_,192-255"

-- printable characters
vim.opt.isprint = "@,161-255"

-- two spaces after a period with a join command
vim.opt.joinspaces = false

-- specifies how jumping is done
vim.opt.jumpoptions = "clean"

-- name of a keyboard mapping
--vim.opt.keymap

-- enable starting/stopping selection with keys
--vim.opt.keymodel

-- program to use for the "K" command
vim.opt.keywordprg = ":Man"

-- alphabetic characters for other language mode
--vim.opt.langmap

-- language to be used for the menus
--vim.opt.langmenu

-- do not apply 'langmap' to mapped characters (obsolete)
--vim.opt.langnoremap

-- do apply 'langmap' to mapped characters
vim.opt.langremap = false

-- tells when last window has status lines
vim.opt.laststatus = 2

-- don't redraw while executing macros
vim.opt.lazyredraw = false

-- maximum number of location lists in history
vim.opt.lhistory = 10

-- wrap long lines at a blank
vim.opt.linebreak = false

-- number of lines in the display
--vim.opt.lines

-- number of pixel lines to use between characters
vim.opt.linespace = 0

-- automatic indenting for Lisp
vim.opt.lisp = false

-- changes how Lisp indenting is done
--vim.opt.lispoptions

-- words that change how lisp indenting works
--vim.opt.lispwords

-- show <Tab> and <EOL>
vim.opt.list = true

-- characters for displaying in list mode
vim.opt.listchars = {
  tab = ">-",
  trail = "*",
  nbsp = "+",
  space = "⋅",
}

-- load plugin scripts when starting up
vim.opt.loadplugins = true

-- changes special characters in search patterns
--vim.opt.magic

-- name of the errorfile for ":make"
--vim.opt.makeef

-- encoding of external make/grep commands
--vim.opt.makeencoding

-- program to use for the ":make" command
vim.opt.makeprg = "make"

-- pairs of characters that "%" can match
vim.opt.matchpairs = "(:),{:},[:]"

-- tenths of a second to show matching paren
vim.opt.matchtime = 5

-- maximum nr of combining characters displayed
vim.opt.maxcombine = 6

-- maximum recursive depth for user functions
vim.opt.maxfuncdepth = 100

-- maximum recursive depth for mapping
vim.opt.maxmapdepth = 1000

-- maximum memory (in Kbyte) used for pattern search
vim.opt.maxmempattern = 1000

-- maximum number for the search count feature
vim.opt.maxsearchcount = 999

-- maximum number of items in a menu
vim.opt.menuitems = 25

-- options for outputting messages
vim.opt.messagesopt = "hit-enter,history:500,progress:c"

-- memory used before :mkspell compresses the tree
vim.opt.mkspellmem = "460000,2000,500"

-- recognize modelines at start or end of file
vim.opt.modeline = true

-- allow setting expression options from a modeline
vim.opt.modelineexpr = false

-- number of lines checked for modelines
vim.opt.modelines = 5

-- changes to the text are not possible
vim.opt.modifiable = true

-- buffer has been modified
vim.opt.modified = false

-- pause listings when the whole screen is filled
vim.opt.more = true

-- enable the use of mouse clicks
vim.opt.mouse = "a"

-- keyboard focus follows the mouse
vim.opt.mousefocus = false

-- hide mouse pointer while typing
vim.opt.mousehide = true

-- changes meaning of mouse buttons
vim.opt.mousemodel = "popup_setpos"

-- report mouse moves with <MouseMove>
vim.opt.mousemoveevent = true

-- amount to scroll by when scrolling with a mouse
vim.opt.mousescroll = "ver:3,hor:6"

-- XXX: not documented

-- shape of the mouse pointer in different modes
--vim.opt.mouseshape

-- max time between mouse double-click
vim.opt.mousetime = 500

-- number formats recognized for CTRL-A command
vim.opt.nrformats = "bin,hex"

-- print the line number in front of each line
vim.opt.number = true

-- number of columns used for the line number
vim.opt.numberwidth = 4

-- function for filetype-specific completion
--vim.opt.omnifunc

-- allow reading/writing devices on MS-Windows
vim.opt.opendevice = false

-- function to be called for g@ operator
--vim.opt.operatorfunc

-- path to the pack lock file
--vim.opt.packlockfile

-- list of directories used for packages
--vim.opt.packpath

-- nroff macros that separate paragraphs
--vim.opt.paragraphs

-- allow pasting text (obsolete)
--vim.opt.paste

-- key code that causes 'paste' to toggle (obsolete)
--vim.opt.pastetoggle

-- expression used to patch a file
--vim.opt.patchexpr

-- keep the oldest version of a file
--vim.opt.patchmode

-- list of directories searched with "gf" et.al.
vim.opt.path = ".,,"

-- preserve the indent structure when reindenting
vim.opt.preserveindent = false

-- height of the preview window
vim.opt.previewheight = 12

-- identifies the preview window
vim.opt.previewwindow = false

-- enable prompt in Ex mode
vim.opt.prompt = true

-- XXX: removed?
vim.opt.pumblend = 0

-- border style of the popup menu
--vim.opt.pumborder

-- maximum number of items to show in the popup menu
vim.opt.pumheight = 0

-- XXX: removed?
vim.opt.pummaxwidth = 0

-- minimum width of the popup menu
vim.opt.pumwidth = 15

-- Python version used for pyx* commands
vim.opt.pyxversion = 3

-- customize the quickfix window
--vim.opt.quickfixtextfunc

-- escape characters used in a string
vim.opt.quoteescape = "\\"

-- disallow writing the buffer
vim.opt.readonly = false

-- options for debugging redraw
--vim.opt.redrawdebug

-- timeout for 'hlsearch' and :match highlighting
vim.opt.redrawtime = 2000

-- default regexp engine to use
vim.opt.regexpengine = 0

-- show relative line number in front of each line
vim.opt.relativenumber = true

-- allow mappings to work recursively (obsolete)
--vim.opt.remap

-- threshold for reporting nr. of lines changed
vim.opt.report = 2

-- inserting characters will work backwards
vim.opt.revins = false

-- window is right-to-left oriented
vim.opt.rightleft = false

-- commands for which editing works right-to-left
vim.opt.rightleftcmd = "search"

-- show cursor line and column in the status line
vim.opt.ruler = true

-- custom format for the ruler
--vim.opt.rulerformat

-- list of directories used for runtime files
--vim.opt.runtimepath

-- lines to scroll with CTRL-U and CTRL-D
--vim.opt.scroll

-- XXX: removed?
vim.opt.scrollback = -1

-- scroll in window as other windows scroll
vim.opt.scrollbind = false

-- minimum number of lines to scroll
vim.opt.scrolljump = 1

-- minimum nr. of lines above and below cursor
vim.opt.scrolloff = 0

-- maximum 'scrolloff' padding when not enough lines
vim.opt.scrolloffpad = 0

-- how 'scrollbind' should behave
vim.opt.scrollopt = "ver,jump"

-- nroff macros that separate sections
--vim.opt.sections

-- when to use Select mode instead of Visual mode
--vim.opt.selectmode

-- options for :mksession
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,terminal"

-- XXX: removed?

-- secure mode for reading .vimrc in current dir
vim.opt.secure = false

-- what type of selection to use
vim.opt.selection = "inclusive"

-- use shada file upon startup and exiting
--vim.opt.shada

-- XXX: removed?

--vim.opt.shadafile

-- name of shell to use for external commands
--vim.opt.shell

-- flag to shell to execute one command
vim.opt.shellcmdflag = "-c"

-- string to put output of ":make" in error file
vim.opt.shellpipe = "2>&1| tee"

-- quote character(s) for around shell command
--vim.opt.shellquote

-- string to put output of filter in a temp file
vim.opt.shellredir = ">%s 2>&1"

-- use forward slash for shell file names
if host.is_windows() then
  vim.opt.shellslash = true
end

-- whether to use a temp file for shell commands
vim.opt.shelltemp = false

-- characters to escape when 'shellxquote' is (
--vim.opt.shellxescape

-- like 'shellquote', but include redirection
--vim.opt.shellxquote

-- round indent to multiple of shiftwidth
vim.opt.shiftround = false

-- number of spaces to use for (auto)indent step
vim.opt.shiftwidth = 4

-- list of flags, reduce length of messages
vim.opt.shortmess = "ltToOCF"

-- string to use at the start of wrapped lines
--vim.opt.showbreak

-- show (partial) command somewhere
vim.opt.showcmd = true

-- where to show (partial) command
vim.opt.showcmdloc = "last"

-- show full tag pattern when completing tag
vim.opt.showfulltag = false

-- briefly jump to matching bracket if insert one
vim.opt.showmatch = false

-- message on status line to show current mode
vim.opt.showmode = true

-- tells when the tab pages line is displayed
vim.opt.showtabline = 1

-- minimum number of columns to scroll horizontal
vim.opt.sidescroll = 1

-- min. nr. of columns to left and right of cursor
vim.opt.sidescrolloff = 0

-- when and how to display the sign column
vim.opt.signcolumn = "auto"

-- no ignore case when pattern has uppercase
vim.opt.smartcase = true

-- smart autoindenting for C programs
vim.opt.smartindent = true

-- <Tab> in leading whitespace indents by 'shiftwidth'
vim.opt.smarttab = true

-- scroll by screen lines when 'wrap' is set
vim.opt.smoothscroll = false

-- number of columns between two soft tab stops
vim.opt.softtabstop = 0

-- enable spell checking
vim.opt.spell = false

-- pattern to locate end of a sentence
vim.opt.spellcapcheck = "[.?!]\\_[\\])'\"\\t ]\\+"

-- files where zg and zw store words
-- https://neovim.io/doc/user/options/#''
--vim.opt.spellfile

-- language(s) to do spell checking for
vim.opt.spelllang = "en"

-- options for spell checking
-- https://neovim.io/doc/user/options/#''
--vim.opt.spelloptions

-- method(s) used to suggest spelling corrections
vim.opt.spellsuggest = "best"

-- new window from split is below the current one
vim.opt.splitbelow = false

-- determines scroll behavior for split windows
vim.opt.splitkeep = "cursor"

-- new window is put right of the current one
vim.opt.splitright = false

-- commands move cursor to first non-blank in line
vim.opt.startofline = false

-- custom format for the status column
-- https://neovim.io/doc/user/options/#''
--vim.opt.statuscolumn

-- custom format for the status line
-- https://neovim.io/doc/user/options/#''
--vim.opt.statusline

-- suffixes that are ignored with multiple match
vim.opt.suffixes = ".bak,~,.o,.h,.info,.swp,.obj"

-- suffixes added when searching for a file
-- https://neovim.io/doc/user/options/#''
--vim.opt.suffixesadd

-- whether to use a swapfile for a buffer
--vim.opt.swapfile = false

-- sets behavior when switching to another buffer
vim.opt.switchbuf = "uselast"

-- maximum column to find syntax items
vim.opt.synmaxcol = 3000

-- syntax to be loaded for current buffer
-- https://neovim.io/doc/user/options/#''
--vim.opt.syntax

-- which tab page to focus when closing a tab
-- https://neovim.io/doc/user/options/#''
--vim.opt.tabclose

-- custom format for the console tab pages line
-- https://neovim.io/doc/user/options/#''
--vim.opt.tabline

-- maximum number of tab pages for -p and "tab all"
vim.opt.tabpagemax = 50

-- number of columns between two tab stops
vim.opt.tabstop = 4

-- use binary searching in tags files
vim.opt.tagbsearch = true

-- how to handle case when searching in tags files
vim.opt.tagcase = "followic"

-- function to get list of tag matches
-- https://neovim.io/doc/user/options/#''
--vim.opt.tagfunc

-- number of significant characters for a tag
vim.opt.taglength = 0

-- file names in tag file are relative
vim.opt.tagrelative = true

-- list of file names used by the tag command
vim.opt.tags = "./tags;,tags"

-- push tags onto the tag stack
vim.opt.tagstack = true

-- XXX: removed?

-- name of the terminal
-- https://neovim.io/doc/user/options/#''
--vim.opt.term

-- terminal takes care of bi-directionality
vim.opt.termbidi = false

-- encoding of the terminal (obsolete)
--vim.opt.termencoding

-- enable 24-bit RGB color in the TUI
vim.opt.termguicolors = true

-- key codes filtered out during bracketed paste
vim.opt.termpastefilter = "BS,HT,ESC,DEL"

-- XXX: removed?

vim.opt.termsync = true

-- shorten some messages (obsolete)
--vim.opt.terse

-- maximum width of text that is being inserted
vim.opt.textwidth = 0

-- list of thesaurus files for keyword completion
-- https://neovim.io/doc/user/options/#''
--vim.opt.thesaurus

-- function to be used for thesaurus completion
-- https://neovim.io/doc/user/options/#''
--vim.opt.thesaurusfunc

-- tilde command "~" behaves like an operator
vim.opt.tildeop = false

-- time out on mappings and key codes
vim.opt.timeout = true

-- time out time in milliseconds
vim.opt.timeoutlen = 1000

-- let Vim set the title of the window
vim.opt.title = false

-- percentage of 'columns' used for window title
vim.opt.titlelen = 85

-- old title, restored when exiting
-- https://neovim.io/doc/user/options/#''
--vim.opt.titleold

-- string to use for the Vim window title
-- https://neovim.io/doc/user/options/#''
--vim.opt.titlestring

-- time out on mappings
vim.opt.ttimeout = true

-- time out time for key codes in milliseconds
vim.opt.ttimeoutlen = 50

-- indicates a fast terminal connection (obsolete)
--vim.opt.ttyfast

-- XXX: removed?

-- alias for 'term'
-- https://neovim.io/doc/user/options/#''
--vim.opt.ttytype

-- where to store undo files
-- https://neovim.io/doc/user/options/#''
--vim.opt.undodir

-- save undo information in a file
vim.opt.undofile = false

-- maximum number of changes that can be undone
vim.opt.undolevels = 1000

-- max nr of lines to save for undo on a buffer reload
vim.opt.undoreload = 10000

-- after this many characters flush swap file
vim.opt.updatecount = 200

-- after this many milliseconds flush swap file
vim.opt.updatetime = 250

-- a list of number of columns between soft tab stops
-- https://neovim.io/doc/user/options/#''
--vim.opt.varsofttabstop

-- a list of number of columns between tab stops
-- https://neovim.io/doc/user/options/#''
--vim.opt.vartabstop

-- give informative messages
vim.opt.verbose = 0

-- file to write messages in
-- https://neovim.io/doc/user/options/#''
--vim.opt.verbosefile

-- directory where to store files with :mkview
-- https://neovim.io/doc/user/options/#''
--vim.opt.viewdir

-- specifies what to save for :mkview
vim.opt.viewoptions = "folds,cursor,curdir"

-- when to use virtual editing
-- https://neovim.io/doc/user/options/#''
--vim.opt.virtualedit

-- use visual bell instead of beeping
vim.opt.visualbell = true

-- warn for shell command when buffer was changed
vim.opt.warn = true

-- allow specified keys to cross line boundaries
vim.opt.whichwrap = "b,s"

-- command-line character for wildcard expansion
vim.opt.wildchar = 9

-- like 'wildchar' but also works when mapped
vim.opt.wildcharm = 0

-- files matching these patterns are not completed
-- https://neovim.io/doc/user/options/#''
--vim.opt.wildignore

-- ignore case when completing file names
vim.opt.wildignorecase = false

-- use menu for command line completion
vim.opt.wildmenu = true

-- mode for 'wildchar' command-line expansion
vim.opt.wildmode = "full"

-- specifies how command line completion is done
vim.opt.wildoptions = "pum,tagfile"

-- when the windows system handles ALT keys
vim.opt.winaltkeys = "menu"

-- custom format for the window bar
--vim.opt.winbar

-- controls transparency of floating windows
vim.opt.winblend = 0

-- default border style of floating windows
--vim.opt.winborder

-- nr of lines to scroll for CTRL-F and CTRL-B
-- https://neovim.io/doc/user/options/#''
--vim.opt.window

-- keep window focused on a single buffer
vim.opt.winfixbuf = false

-- keep window height when opening/closing windows
vim.opt.winfixheight = true

-- keep window width when opening/closing windows
vim.opt.winfixwidth = true

-- minimum number of lines for the current window
vim.opt.winheight = 1

-- window-local highlighting
-- https://neovim.io/doc/user/options/#''
--vim.opt.winhighlight

-- minimum number of lines for any window
vim.opt.winminheight = 1

-- minimal number of columns for any window
vim.opt.winminwidth = 1

-- keep window pinned when switching buffers
vim.opt.winpinned = false

-- minimal number of columns for current window
vim.opt.winwidth = 20

-- long lines wrap and continue on the next line
vim.opt.wrap = true

-- chars from the right where wrapping starts
vim.opt.wrapmargin = 0

-- searches wrap around the end of the file
vim.opt.wrapscan = true

-- writing to a file is allowed
vim.opt.write = true

-- write to file with no need for "!" override
vim.opt.writeany = false

-- make a backup before overwriting a file
vim.opt.writebackup = true

-- delay this many msec for each char (for debug)
vim.opt.writedelay = 0
