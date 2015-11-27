" Colorscheme {{{
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

set shell=/usr/bin/fish " Bounce

set autoread " Keep file in sync
"   set number   " Add Line numbers , but I no want now
set backspace=eol,start,indent " Backspace stuff
set hlsearch " highlight search results.
set incsearch " Like Google Instant for Vim
" Fix seach colors
hi Search cterm=NONE ctermfg=NONE ctermbg=white
set lazyredraw " Don't redraw when not interactive
set magic " Make regexes work better... but not perfect
set showmatch " Indicate when a matching paren is typed
if !has('nvim')
    set encoding=utf8
    " Possibly second most important command ever
endif
set ffs=unix " One true line ending format
set expandtab " Expand tabs to spaces
set showcmd " Shows command as you type it, like Emacs
set scrolloff=2 " Keep five lines away from edge of screen
set clipboard=unnamedplus " Use the system clipboard
" Tab good
set smarttab
set shiftwidth=4
set tabstop=4
" But not in HTML
" autocmd FileType html setl sw=2 ts=2 " Yes in HTML

set shiftwidth=4
set tabstop=4

" Indentation good
set autoindent
set smartindent
" This entire block of code is irrelevent since Neovim has
" truecolor support
" if $TERM ==# "linux"
"     set t_Co=8 " linux terminal is 8-color only
" else
"     set t_Co=16 " Use 16 colors only
" endif
set mouse=a " Mouse support
set colorcolumn=80 " Indicate when lines are too long
set matchtime=1 " Speed things up
set foldmethod=syntax " Get some folding action
set foldlevelstart=99 " Don't auto-close folds

set visualbell t_vb= " Get rid of that damn beeping
set virtualedit=block " holy shit why is this not the default
let c_gnu=1 " Real men use GCC
" Statusline stuff
set laststatus=2

syntax enable " Most important command ever

let mapleader = " "
let maplocalleader = ','
" }}}
" Syntastic stuff {{{
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
let python_highlight_all = 1 " Python syntax
let python_highlight_space_errors = 0
" }}}
" Airline {{{
let g:airline_theme='solarized'
let g:airline_powerline_fonts = 1
set noshowmode

" }}}
" Pydoc {{{
let g:pydoc_cmd = "pydoc3"
let g:pydoc_open_cmd = "tabnew"

let g:python_host_prog = "/usr/bin/python"
let g:python3_host_prog = "/usr/bin/python3"
" }}}
