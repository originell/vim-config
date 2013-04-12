""" originell vimrc
"""
""" If you are using MacVIM note that
""" <leader> means \

set nocompatible     " be iMproved
filetype off         " required for Vundle

set foldmethod=marker
set foldlevel=99

" Use ctrl+movement keys instead of ctrl+w 
" to move between buffers
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Swap motion repeat forwards (;) and backwards (,)
" I find it quicker to just press , in order to repeat my last movement
" forwards and ; to do it backwards. It's rare that I move back. FUTURE!
noremap ; ,
noremap , ;

" Minimum window height 5 lines
" current window always at min 30 lines
set winheight=30
set winminheight=5

" Make buffer resizing more sensible - thanks to
" http://www.readncode.com/blog/resizing-vim-window-splits-like-a-boss/
nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> - :exe "resize " . (winheight(0) * 2/3)<CR>

" Vundle
" Brief help
"
" :BundleInstall  - install bundles (won't update installed)
" :BundleInstall! - update if installed
"
" :Bundles foo    - search for foo
" :Bundles! foo   - refresh cached list and search for foo
"
" :BundleClean    - confirm removal of unused bundles
" :BundleClean!   - remove without confirmation
"
" see :h vundle for more details
" or wiki for FAQ
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles:
" ==========
"
" Repos on GitHub
" ---------------
"
" GIT integration
Bundle 'tpope/vim-fugitive'
" GIT Syntax
Bundle 'tpope/vim-git'
" Python Mode <3
Bundle 'klen/python-mode'
" Python + Jedi => Autocomplete awesome
Bundle 'davidhalter/jedi-vim'
" TextMate Style Snippets
"   Dependencies
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "honza/snipmate-snippets"
"   The actual plugin.
Bundle 'garbas/vim-snipmate'
" Put the Tab on steroids!
Bundle 'ervandew/supertab'
" Filebrowser
Bundle 'scrooloose/nerdtree'
" Comments for multiple langs
Bundle 'scrooloose/nerdcommenter'
" Ack (awesome grep)
Bundle 'mileszs/ack.vim'
" some HTML5 stuff :)
Bundle 'othree/html5.vim'
" Beautify the status line! This is awesome. Thanks indygemma!
Bundle 'Lokaltog/vim-powerline'
" A scratch buffer
Bundle 'k-f-/vim-scratch'
" Python (and maybe other similar looking languages) Parameters Swapper
Bundle 'mutewinter/swap-parameters'
" HaXe support
Bundle 'jdonaldson/vaxe'
" Autoclosing brackets/paranthesis/...
Bundle 'Townk/vim-autoclose'

" Github vim-script/ repo
" -----------------------
" *.log syntax
Bundle 'syslog-syntax-file'
" Clojure :)
Bundle 'VimClojure'

" Original git repos
" ------------------
"
" To properly install "command-t" don't forget to compile the C-extension
"
"   $ cd ~/.vim/bundle/command-t/ruby/command-t
"   $ ruby extconf.h
"   $ make
"
Bundle 'git://git.wincent.com/command-t.git'


filetype plugin indent on     " required for Vundle

map <leader>g :GundoToggle<CR>

" disable pyflakes quickfix window
"let g:pyflakes_use_quickfix = 0

" python pep8 violations in quickfix window
let g:pep8_map='<leader>8'

" SuperTab lets us use tab for autocompletion in
" insert mode
let g:SuperTabDefaultCompletionType = 'context'

" Powerline Fancy Font :)
" You should really try this! See the Powerline readme.
let g:Powerline_symbols = 'fancy'

" pydoc preview :D
" <leader>pw opens pydoc for current module
set completeopt=menuone,longest,preview

" NERD tree
map <leader>n :NERDTreeToggle<CR>
"" ignnore .pyc files
let NERDTreeIgnore = ['\.pyc$']

" Python Rope
map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>

" ACK plugin :) (grep but with lot more awesome)
nmap <leader>a <Esc>:Ack!

" configure MakeGreen to use django manage.py test
map <leader>dt :set makeprg=python\ manage.py\ test\|:call MakeGreen()<CR>

" === Disabled ===
" I don't need it right now and it 
" slows down start of CommandT
" so I'd need to remap it.. Feel free to do that ;-)
" ================
" py.test for more functionality for tests (individual files, classes,
" methods)
"" Execute the tests
"nmap <silent><Leader>tf <Esc>:Pytest file<CR>
"nmap <silent><Leader>tc <Esc>:Pytest class<CR>
"nmap <silent><Leader>tm <Esc>:Pytest method<CR>
"" cycle through test errors
"nmap <silent><Leader>tn <Esc>:Pytest next<CR>
"nmap <silent><Leader>tp <Esc>:Pytest previous<CR>
"nmap <silent><Leader>te <Esc>:Pytest error<CR>

""" ====================
""" General VIM Settings
""" ====================

" Syntax highlighting
syntax on
" linenumbers
set number
" set incremental search (search while typing)
set incsearch
" on search, highlight findings
set hlsearch
" Disable the (visual) bell
set vb t_vb=
" Always show the status line
set laststatus=2
" Always display those nice little infos
" bottom right.
set ruler
" Allow changing buffers without saving
set hidden


" 1 Tab == 4 Spaces
set tabstop=4
" How many columns get inserted by reindent operations
set shiftwidth=4
" Insert blanks according to tabstop && shiftwidth
set smarttab
" Tab in insert mode indents
set expandtab
" well, automatic C style indentation
set autoindent

" display tabs and spaces
set listchars=tab:»·,trail:· 
" show trailing spaces as a circle. turn off with 'set nolist'
set list

" Highlight inconsistencies mixing tabs and spaces
" -- thx indygemma
highlight BadSpacing term=standout ctermbg=cyan
augroup Spacing
    autocmd!
    " Highlight tabulators and trailing spaces (nasty bastards)
    autocmd BufNewFile,BufReadPre * match BadSpacing /\(\t\|  *$\)/
    " Only highlight trailing space in tab-filled formats
    autocmd FileType help,make match BadSpacing /  *$/
augroup END

" source vimrc with <leader>s
map <Leader>s :source $MYVIMRC<cr>
" open up .vimrc in a vertical split with <leader>vv
map <Leader>vv <c-w><c-v>:e $MYVIMRC<cr>

" set the backup dir to declutter working directory.
" two ending slashes means, full path to the actual filename
" -- thanks to indygemma
silent! !mkdir -p ~/.vim/backup
silent! !mkdir -p ~/.vim/swap
silent! !mkdir -p ~/.vim/undo
set backup
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
" Persistent undos (vim 7.3+)
set undofile
set undodir=~/.vim/undo//

" Thanks to John Resig for the following 2 things:
"
" Tell vim to remember certain things when we exit
"   '10 : marks will be remembered for up to 10 previously edited files
"   "100 : will save up to 100 lines for each register
"   :20 : up to 20 lines of command-line history will be remembered
"   % : saves and restores the buffer list
"   n... : where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

" when we reload, tell vim to restore the cursor to the saved position
augroup JumpCursorOnEdit
    au!
    autocmd BufReadPost *
    \ if expand("<afile>:p:h") !=? $TEMP |
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \ let JumpCursorOnEdit_foo = line("'\"") |
    \ let b:doopenfold = 1 |
    \ if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
    \ let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
    \ let b:doopenfold = 2 |
    \ endif |
    \ exe JumpCursorOnEdit_foo |
    \ endif |
    \ endif
    " Need to postpone using "zv" until after reading the modelines.
    autocmd BufWinEnter *
    \ if exists("b:doopenfold") |
    \ exe "normal zv" |
    \ if(b:doopenfold > 1) |
    \ exe "+".1 |
    \ endif |
    \ unlet b:doopenfold |
    \ endif
augroup END


" vim7.3+ has colorcolumn support - otherwise fake it
"             ^-  highlight linelengths exceeding XX
if exists('+colorcolumn')
    set colorcolumn=79
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%79v.\+', -1)
endif

" Color Scheme
" Enable 256 Color support in VIM, so we can use
" zenburn also in console.
set t_Co=256
set background=dark
colorscheme zenburn
if has("gui_running")
    " Remove toolbar
    set guioptions-=T
endif

" Highlight the current line
set cursorline

" GUI Options (MacVim/gVim)
set guifont=Inconsolata:h14.00

" When doing :e and pressing TAB
" this will list the contents of
" the current directory.
" See http://vim.wikia.com/wiki/Great_wildmode/wildmenu_and_console_mouse
set wildmenu
set wildmode=list:longest,full

" Enable mouse support for console vim
set mouse=a

" Omni Completion
au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
au FileType html set omnifunc=htmlcomplete#CompleteTags
au FileType css set omnifunc=csscomplete#CompleteCSS
au FileType python set omnifunc=pythoncomplete#Complete
au FileType php set omnifunc=phpcomplete#CompletePHP

" robhudson's django snipmate bundle includes lots of
" snippets. If you are not working a lot with django
" and django/jinja templates, comment the following
" lines
au FileType python set ft=python.django
au FileType html set ft=htmldjango.html

" JSON highlight
autocmd BufNewFile,BufRead *.json set ft=javascript

" pip requirements.txt is OK to be highlighted as Python.
autocmd BufNewFile,BufRead requirements.txt set ft=python

" Use indent as foldmethod in python.
" THX to
" http://stackoverflow.com/questions/357785/what-is-the-recommended-way-to-use-vim-folding-for-python-coding
au FileType python set foldmethod=indent
" Do not fold internal statements.
au FileType python set foldnestmax=2

" Fold/Unfold with Shift+Space
nnoremap <s-space> za
vnoremap <s-space> zf

" PHP Stuff
let php_sql_query=1      " Highlight SQL in strings
let php_htmlInStrings=1  " Highlight HTML in strings

" Python Mode Settings
" ====================
let g:pymode_run = 0          " Dont load the python run code within vim plugin
let g:pymode_lint_write = 1   " enable code checking on every save
let g:pymode_lint_onfly = 0   " dont run code checking on the fly
let g:pymode_breakpoint = 0   " disable the breakpoint plugin (I have an ipdb
                              " snippet for that)
let g:pymode_lint_cwindow = 0 " dont autoopen the quickfix window on errors
let g:pymode_lint_hold = 1    " hold the cursor in the window instead of
                              "jumping to quickfix
let g:pymode_lint_ignore = "E127,E128,E123,E124"  " I have an indent style that
                                             " linters dont like it usually.
let g:pymode_rope = 1  " We have JEDI now!
"
" Jedi
" ====
let g:jedi#related_names_command = "<leader>e"

" CommandT Options
" ===============
let g:CommandTMaxHeight = 15          " Maximum window height.
let g:CommandTMatchWindowReverse = 1  " Show the top match at the bottom
                                      " instead of top.
                                      " I think this is better cause its always
                                      " at a fixed position instead of jumping
                                      " around.

" CommandT respects vim's wildignore setting.
set wildignore+=*.o,*.obj,.git,*.pyc,static/**

" Clojure  (via VimClojure)
let vimclojure#HighlightBuiltins=1   " Highlight Clojure's builtins
let vimclojure#ParenRainbow=1        " Rainbows :)
