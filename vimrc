""" originell vimrc
"""
""" If you are using MacVIM note that
""" <leader> means \

set nocompatible     " be iMproved
filetype off         " required for Vundle

set foldmethod=indent
set foldlevel=99

" Use ctrl+movement keys instead of ctrl+w 
" to move between buffers
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h


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
"
" Repos on GitHub
" ===============
"
" GIT integration
"Bundle 'tpope/vim-fugitive'
" Deal with pairs of surroundings
Bundle 'tpope/vim-surround'
" GIT Syntax
Bundle 'tpope/vim-git'
Bundle 'msanders/snipmate.vim'
Bundle 'ervandew/supertab'
"Bundle 'fholgado/minibufexpl.vim'
Bundle 'sontek/rope-vim'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'mileszs/ack.vim'
Bundle 'sjl/gundo.vim'
Bundle 'fs111/pydoc.vim'
Bundle 'alfredodeza/pytest.vim'
Bundle 'reinh/vim-makegreen'
Bundle 'vim-scripts/pep8'
Bundle 'vim-scripts/TaskList.vim'
Bundle 'othree/html5.vim'
"Bundle 'kevinw/pyflakes-vim'
Bundle 'robhudson/snipmate_for_django'
" original git repos
"
" To properly install "command-t" don't forget to compile the C-extension
"
"   $ cd ~/.vim/bundle/command-t/ruby/command-t
"   $ ruby extconf.h
"   $ make
"
Bundle 'git://git.wincent.com/command-t.git'


filetype plugin indent on     " required for Vundle 

" TaskList default mapping is <leader>t, which basically always
" conflicts with other plugins.
" furthermore it would slow down the opening of CommandT
nmap <leader>do <Plug>TaskList

map <leader>g :GundoToggle<CR>

" disable pyflakes quickfix window
let g:pyflakes_use_quickfix = 0

" python pep8 violations in quickfix window
let g:pep8_map='<leader>8'

" SuperTab lets us use tab for autocompletion in
" insert mode
let g:SuperTabDefaultCompletionType = 'context'

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
" on search, highlight findings
set hlsearch

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
set backup
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//

" vim7.3+ has colorcolumn support - otherwise fake it
"             ^-  highlight linelenghts exceeding XX
if exists('+colorcolumn')
    set colorcolumn=79
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%79v.\+', -1)
endif

" Color Scheme
set background=dark
if has("gui_running")
    colorscheme zenburn
else
    colorscheme desert
endif

" GUI Options (MacVim/gVim)
set guifont=Inconsolata:h14.00

" Omni Completion
au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
au FileType html set omnifunc=htmlcomplete#CompleteTags
au FileType css set omnifunc=csscomplete#CompleteCSS
au FileType python set omnifunc=pythoncomplete#Complete

" robhudson's django snipmate bundle includes lots of
" snippets. If you are not working a lot with django
" and django/jinja templates, comment the following
" lines
au FileType python set ft=python.django
au FileType html set ft=htmldjango.html

" Use jj instead of ESC since it's pretty much
" of a stretch with the hand.
imap jj <Esc>
