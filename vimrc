""" My VimRC
"""
""" If you are using MacVIM note that
""" <leader> means \

set nocompatible     " be iMproved
filetype off         " required for Vundle

" Vundle
" see :h vundle for more details or wiki for FAQ
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'VundleVim/Vundle.vim'

" My Plugins:
" ==========
"
" Repos on GitHub
" ---------------
"
" .editorconfig support
Plugin 'editorconfig/editorconfig-vim'
" GIT integration
Plugin 'tpope/vim-fugitive'
" GIT Syntax
Plugin 'tpope/vim-git'
" Python Mode <3
Plugin 'klen/python-mode'
" requirements.txt syntax highlight
Plugin 'raimon49/requirements.txt.vim'
" TextMate Style Snippets
Plugin 'SirVer/ultisnips'
" Filebrowser
Plugin 'scrooloose/nerdtree'
" Comments for multiple langs
Plugin 'tomtom/tcomment_vim'
" Syntastic! Syntax checking for all the languages ;-)
Plugin 'scrooloose/syntastic'
" Ag (faster Ack, awesome grep)
Plugin 'rking/ag.vim'
" some HTML5 stuff :)
Plugin 'othree/html5.vim'
" Beautify the status line! This is awesome. Thanks indygemma!
Bundle 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
" Autoclosing brackets/paranthesis/...
Plugin 'Raimondi/delimitMate'
" CSS3 Support
Plugin 'hail2u/vim-css3-syntax'
" SASS/SCSS
Plugin 'tpope/vim-haml'
" Superfast auto complete
" also contains Jedi for Python autocomplete etc.
Plugin 'Valloric/YouCompleteMe'
" JS autocomplete by TernJS via YCM
Plugin 'marijnh/tern_for_vim'
" Extremely awesome HTML tag highlight
Plugin 'Valloric/MatchTagAlways'
" Markdown highlight
Plugin 'plasticboy/vim-markdown'
" Vim surround for quick wrapping
Plugin 'tpope/vim-surround'
" Quick file open and buffer open
Plugin 'kien/ctrlp.vim'
" JSX Support (for React)
Plugin 'mxw/vim-jsx'
" New JavaScript Indent and Highlighter. Required for vim-jsx
Plugin 'pangloss/vim-javascript'
" Ansible
Plugin 'pearofducks/ansible-vim'
" Golang support
Plugin 'fatih/vim-go'

" Github vim-script/ repo
" -----------------------
" *.log syntax
Plugin 'syslog-syntax-file'

call vundle#end()            " required for Vundle
filetype plugin indent on    " required for Vundle


""" ====================
""" Plugin Settings
""" ====================

" Ignores for CtrlP
let g:ctrlp_custom_ignore = '\v[\/]\.(DS_Storegit|hg|svn|optimized|compiled|node_modules)$'

" Load matchit for advanced opening/closing matches (HTML,...)
runtime macros/matchit.vim

" python pep8 violations in quickfix window
let g:pep8_map='<leader>8'

" Powerline Fancy Font :)
" You should really try this! See the Powerline readme.
let g:Powerline_symbols = 'fancy'

" NERD tree
map <leader>n :NERDTreeToggle<CR>
"" ignnore .pyc files
let NERDTreeIgnore = ['\.pyc$']

" Python Rope
map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>

" Ag plugin :) (faster Ack, so grep but with lot more awesome)
nmap <leader>a <Esc>:Ag!

" Inline JSX Support
let g:jsx_ext_required = 0

" Python Mode Settings
" ====================
let g:pymode_virtualenv = 1   " Enable Virtualenv Detection for PyMode
let g:pymode_run = 0          " Dont load the python run code within vim plugin
let g:pymode_breakpoint = 0   " disable the breakpoint plugin (I have an ipdb
                              " snippet for that)
let g:pymode_lint = 0         " Disable this lint. We'll use Syntastic.
" I have an indent style that linters dont like, usually. (E123-E128)
" Also I don't need the semicolon warning, since that only occurs when I set
" an ipdb breakpoint. (E702)
let g:pymode_lint_ignore = "E127,E128,E123,E124,E702,E501"
let g:pymode_rope = 0  " We have YCM now (which integrates Jedi)

" Jedi
let g:jedi#completions_enabled = 0 " Disable Jedi as YCM will use Jedi
let g:jedi#goto_command = "<C-g>"

" YouCompleteMe should not clash with UltiSnip's key mappings
let g:ycm_key_list_select_completion = ['<Down>']

" MatchTagAlways include Django HTML Filetype
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'htmldjango.html' : 1,
    \ 'jinja' : 1,
    \}

" Syntastic should use ESLint for JSX support
let g:syntastic_javascript_checkers = ['eslint']

""" ====================
""" General VIM Settings
""" ====================

"" Enable line wrapping preserving indent level (vim 8+)
if exists("+breakindent")
    set breakindent
endif

"" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" CtrlP respects vim's wildignore setting.
set wildignore+=*.o,*.obj,.git,*.pyc,static/**,node_modules/**

set foldmethod=marker   " Put special characters where a line wraps
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

" Make buffer resizing more sensible - thanks to
" http://www.readncode.com/blog/resizing-vim-window-splits-like-a-boss/
nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> - :exe "resize " . (winheight(0) * 2/3)<CR>

" Syntax highlighting
syntax on
" linenumbers
set number
" set incremental search (search while typing)
set incsearch
" on search, highlight findings
set hlsearch
" ignore case on search because...
set ignorecase
" ... we enable smartcase which goes case-sensitive when an uppercase letter
" is found
set smartcase
" show extra info about the previous command
set showcmd
" Disable the (visual) bell
set vb t_vb=
" Always show the status line
set laststatus=2
" Hide the default mode text (e.g. -- INSERT -- below the
" statusline)
set noshowmode
" Always display those nice little infos
" bottom right.
set ruler
" Allow changing buffers without saving
set hidden


" 1 Tab == 4 Spaces
set tabstop=4
" How many columns get inserted by reindent operations
set shiftwidth=4
" When indenting, round to the next multiple of shiftwidth
" (character is at position 6, indenting would move it to 8 instead
" of 10 (6+shiftwidth))
set shiftround
" Insert blanks according to tabstop && shiftwidth
set smarttab
" Tab in insert mode indents
set expandtab
" well, automatic indentation
set autoindent

" show trailing spaces as a circle. turn off with 'set nolist'
set list
" display tabs and spaces
set listchars=tab:»·,trail:·
" overwrite zenburn colorscheme colors for the listchars highlight to
" something less visible.
autocmd ColorScheme * highlight NonText guifg=#4a4a59
autocmd ColorScheme * highlight SpecialKey guifg=#4a4a59

" Highlight inconsistencies mixing tabs and spaces
" -- thx indygemma
autocmd ColorScheme * highlight BadSpacing term=standout ctermbg=cyan
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
" make molokai more sublime-like
let g:molokai_original = 1

if has("gui_running")
    " Remove toolbar
    set guioptions-=T
    " Remove left scrollbar
    set guioptions-=L
    " Remove right scrollbar
    set guioptions-=r
    " Adobe's cool new hot Source Code Font
    set guifont=Inconsolata-dz\ for\ Powerline:h12
endif

" Powerline: fix terminal timeout when pressing ESC
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
    " Syntax coloring lines of long lines lags a lot.
    set synmaxcol=128
    " Fast terminal
    set ttyfast
    " Scroll 3 lines at a time
    set ttyscroll=3
    " Avoid scrolling problems
    set lazyredraw
endif

" Highlight the current line
set cursorline

" Vertical fill character for stuff like splits etc.
set fillchars=vert:│

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
autocmd BufNewFile,BufRead *.json set ft=json

" The Guardfile (awesome Guard project) is ruby
autocmd BufNewFile,BufRead Guardfile set ft=ruby

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
