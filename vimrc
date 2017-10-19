""" My VimRC
" <leader> means \
set nocompatible     " be iMproved


""" Plugins
" Managed by vim-plug.
" Auto install vim-plug:
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" 
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" Repos on GitHub
" A gazillion language syntax and indent files <3
Plug 'sheerun/vim-polyglot'
" GIT integration
Plug 'tpope/vim-fugitive'
" GIT Syntax
Plug 'tpope/vim-git'
" GIT.. well.. Gutter
Plug 'airblade/vim-gitgutter'
" Filebrowser
Plug 'scrooloose/nerdtree'
" Comments for multiple langs
Plug 'scrooloose/nerdcommenter'
" Syntax checking for all the languages
Plug 'w0rp/ale'
" Ripgrep (faster grep with features from ag)
Plug 'jremmen/vim-ripgrep'
" Beautify the status line! This is awesome. Thanks indygemma!
Plug 'vim-airline/vim-airline'
" Autoclosing brackets/paranthesis/...
Plug 'Raimondi/delimitMate'
" Superfast auto complete
" Conditional re-building YCM
" also contains Jedi for Python autocomplete etc.
function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py --clang-completer --gocode-completer --tern-completer
  endif
endfunction
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
" Extremely awesome HTML tag highlight
Plug 'Valloric/MatchTagAlways'
" Vim surround for quick wrapping
Plug 'tpope/vim-surround'
" Quick file open
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Python Import Sorting
Plug 'fisadev/vim-isort'
" Solarized. Because I need a light colorscheme when I'm sitting in the sun
Plug 'altercation/vim-colors-solarized'
" Ctags Overview (overview of classes and methods in a project/file)
Plug 'majutsushi/tagbar'
" Following Plugins are taken from https://github.com/sheerun/vim-polyglot
" Make vimdiff more useful by highlighting the exact characters that are
" different.
Plug 'rickhowe/diffchar.vim'
call plug#end()


""" Plugin Settings
" Load matchit for advanced opening/closing matches (HTML,...)
runtime macros/matchit.vim
" NERD tree
function! OpenOrFocusNERDTree()
    let nerdtree_open_in_current_tab = exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1
    if nerdtree_open_in_current_tab
        let current_buffer = bufwinnr("%")
        let nerdtree_buffer = bufwinnr(t:NERDTreeBufName)
        if current_buffer == nerdtree_buffer
            :NERDTreeToggle
        else
            :NERDTreeFocus
        endif
    else
        :NERDTreeToggle
    endif
endfunction
map <leader>n :call OpenOrFocusNERDTree()<CR>
map <leader>f :NERDTreeFind<CR>
" ignnore .pyc files
let NERDTreeIgnore = ['\.pyc$', '^__pycache__$']
" Ripgrep plugin
nmap <leader>a <Esc>:Rg
" Inline JSX Support
let g:jsx_ext_required = 0
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
" ALE Fixers (code formatters)
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fixers['javascript.jsx'] = ['prettier']
let g:ale_fixers['css'] = ['prettier']
let g:ale_fixers['scss'] = ['prettier']
let g:ale_fixers['python'] = ['yapf']
" ALE auto format on save
let g:ale_fix_on_save = 1
" Create-React-App Type prettier settings
let g:ale_javascript_prettier_options = '--single-quote --tab-width 4 --no-semi --trailing-comma all'
let g:ale_css_prettier_options = '--single-quote --tab-width 4 --no-semi --trailing-comma all'
let g:ale_scss_prettier_options = '--single-quote --tab-width 4 --no-semi --trailing-comma all'
" ALE
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
highlight link ALEWarningSign String
highlight link ALEErrorSign Title
" Let airline use Powerline fonts
let g:airline_powerline_fonts = 1
" Map YouCompleteMe GoTo
nnoremap <leader>d :YcmCompleter GoTo<CR>
" Map fzf (fuzzy finder)
nmap <Leader>t :Files<CR>
nmap <Leader>r :Tags<CR>
nmap <Leader>b :Buffers<CR>
" GitGutter Ripgrep
let g:gitgutter_grep_command = 'rg --hidden --follow --glob "!.git/*"'
" GitGutter styling to use · instead of +/-
let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '∙'
let g:gitgutter_sign_modified_removed = '∙'


""" General VIM Settings
" Enable line wrapping preserving indent level (vim 8+)
if exists("+breakindent")
    set breakindent
endif
" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'
" Ignore these files/directories
set wildignore+=*.o,*.obj,.git,*.pyc,static/**,node_modules/**
" Put special characters where a line wraps
set foldmethod=marker
set foldlevel=99
" Use ctrl+movement keys instead of ctrl+w to move between buffers
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
" Show for lines that have been wrapped, like Emacs
set showbreak=
" display tabs and spaces
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
" Highlight matching braces/parens/etc.
set showmatch
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
" MacVIM settings
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
" Highlight the current line
set cursorline
" Unicode chars for diffs/folds, and rely on Colors for window borders
set fillchars=vert:\ ,stl:\ ,stlnc:\ ,fold:-,diff:┄
" When doing :e and pressing TAB
" this will list the contents of
" the current directory.
" See http://vim.wikia.com/wiki/Great_wildmode/wildmenu_and_console_mouse
set wildmenu
set wildmode=list:longest,full
" Enable mouse support for console vim
set mouse=a
"
set formatoptions=tcqn1     " t - autowrap normal text
                            " c - autowrap comments
                            " q - gq formats comments
                            " n - autowrap lists
                            " 1 - break _before_ single-letter words
                            " 2 - use indenting from 2nd line of para
" Tagbar mapping
nmap <F8> :TagbarToggle<CR>
" Airline ALE support
let g:airline#extensions#ale#enabled = 1


""" Python Settings
" Force Jedi to use pyenv python.
"if jedi#init_python()
"  function! s:jedi_auto_force_py_version() abort
"    let major_version = pyenv#python#get_internal_major_version()
"    call jedi#force_py_version(major_version)
"  endfunction
"  augroup vim-pyenv-custom-augroup
"    autocmd! *
"    autocmd User vim-pyenv-activate-post   call s:jedi_auto_force_py_version()
"    autocmd User vim-pyenv-deactivate-post call s:jedi_auto_force_py_version()
"  augroup END
"endif
" Use indent as foldmethod in python.
" THX to
" http://stackoverflow.com/questions/357785/what-is-the-recommended-way-to-use-vim-folding-for-python-coding
au FileType python set foldmethod=indent
" Do not fold internal statements.
au FileType python set foldnestmax=2
" Python Syntax HL options
let python_highlight_all=1
let python_slow_sync=1
" When I'm working with python and/or html files, it is usually in a django
" project.
"au FileType python set ft=python.django
"au FileType html set ft=htmldjango.html
" Python import sorting can be run with leader+i
let g:vim_isort_map = '<C-i>'
" Fold/Unfold with Shift+Space
nnoremap <s-space> za
vnoremap <s-space> zf


""" PHP Settings
let php_sql_query=1      " Highlight SQL in strings
let php_htmlInStrings=1  " Highlight HTML in strings


""" Terraform Settings
" Let terraform override my vim indentation settings
" so it's compliant to the community standards.
let g:terraform_align=1
" When saving a terraform file, automatically format it.
let g:terraform_fmt_on_save=1
