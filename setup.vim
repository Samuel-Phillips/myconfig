" Colorscheme {{{
if $NVIM_TUI_ENABLE_TRUE_COLOR
    set termguicolors
endif
set background=dark
colorscheme solarized

let g:solarized_termtrans=1
" let g:solarized_degrade=0
let g:solarized_bold=1
let g:solarized_underline=1
let g:solarized_italic=1
let g:solarized_menu=1
" let g:solarized_termcolors=16
" let g:solarized_contrast="normal"
" let g:solarized_visibility="normal"
" let g:solarized_diffmode="normal"
" let g:solarized_hitrail=0
"
" }}}
" Basic Setup {{{
filetype on
filetype plugin on
filetype indent on

set shell=/usr/bin/fish

set autoread " Keep file in sync
"   set number   " Add Line numbers
set backspace=eol,start,indent " Backspace stuff
set hlsearch " highlight search results.
set incsearch
" Fix search colors
hi Search cterm=NONE ctermfg=NONE ctermbg=white
set lazyredraw " Don't redraw when not interactive
set magic " Make regexes work better... sadly no set verymagic
set showmatch " Indicate when a matching paren is typed
if !has('nvim')
    set encoding=utf8
endif
set fileformats=unix
set showcmd " Shows command as you type it
set scrolloff=2 " Keep two lines away from edge of screen
set clipboard=unnamedplus " Use the system clipboard

" Tab / space settings
" 4-space indents, spaces
set expandtab
set smarttab
set tabstop=4
set shiftwidth=4
set softtabstop=4

set autoindent
set smartindent

set mouse=a " Mouse support
set matchtime=1 " Speed things up
set foldmethod=syntax
set foldlevelstart=99 " Don't auto-close folds

" s/re/g -> s/re/
set gdefault

" Auto break @ 80 cols
set linebreak
set colorcolumn=+1,+2
set textwidth=80 " 80 cols is the maximum

set visualbell t_vb= " Get rid of that damn beeping
set virtualedit=block " Move cursor anywhere when in block mode
let c_gnu=1 " Highlight gcc stuff, I think

syntax enable

let mapleader = " "
let maplocalleader = ','
" }}}
" scrooloose/syntastic {{{
"   set statusline+=%#warningmsg#
"   set statusline+=%{SyntasticStatuslineFlag()}
"   set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_cpp_compiler= 'g++'
let g:syntastic_cpp_compiler_options = '-std=c++11'
" }}}
" bling/vim-airline {{{
set laststatus=2
set noshowmode
let g:airline_theme='solarized'
let g:airline_powerline_fonts = 1

" }}}
" fs111/pydoc.vim {{{
let g:pydoc_cmd = "pydoc3"
let g:pydoc_open_cmd = "tabnew"

let g:python_host_prog = "/usr/bin/python"
let g:python3_host_prog = "/usr/bin/python3"
" }}}
" hdima/python-syntax {{{
let g:python_highlight_all = 1
let g:python_highlight_space_errors = 0
" }}}
