" Start on a high note
"  execute pathogen#infect()
" Nope, we have vim-plug now

set background=dark
colorscheme solarized

filetype on
filetype plugin on
filetype indent on

set nocompatible " Get this out of the way
set shell=/bin/bash " Sad but true

" Various settings {{{
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
    set encoding=utf8 " Possibly second most important command ever
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
    autocmd FileType html setl sw=2 ts=2 

    set shiftwidth=4
    set tabstop=4

" Indentation good
    set autoindent
    set smartindent
    if $TERM ==# "linux"
        set t_Co=8 " linux terminal is 8-color only
    else
        set t_Co=16 " Use 16 colors only
    endif
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
    " Syntastic stuff
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

syntax enable " Most important command ever

let mapleader = " "
let maplocalleader = ','

" Some Functions {{{
function! s:FixEimacs()
    %s/\v([\[(]) /\1/g
    %s/\v ([\])])/\1/g
    %s/\v ;/;/g
    normal gg=G
endfunction

function! s:Strip(thing)
    return substitute(a:thing, '\v^\s*(.{-})\s*$', '\1', '')
endfunction

"function! s:MakeGooglingFunction(stickinfront)
"    let b:mgf_stickinfront = a:stickinfront
"    function s:TheGoogleFunction(visual)
"        if (a:visual)
"            let l:bak = @"
"            normal y
"            let l:mytext = @"
"            let @" = l:bak
"        else
"            normal mxbyw`x
"            let l:mytext = @"
"        endif
"        let l:query = s:Strip(b:mgf_stickinfront.' '.l:mytext)
"        let l:url = 'https://www.google.com/search?q='.join(split(l:query),'+')
"        call system("xdotool windowactivate $(xdotool search --name '^.*?- Chromium$')")
"        call system("chromium-browser ".shellescape(l:url))
"    endfunction
"endfunction
" }}}

" Many useful mappings {{{
" Capitalization macros
    inoremap <c-u> <esc>mxviwU<esc>`xa
    nnoremap <leader>u mxviwU<esc>`xl

" .vimrc macros
    nnoremap <leader>rc :split $MYVIMRC<cr>G
    nnoremap <leader>src :source $MYVIMRC<cr>
    nnoremap <leader>wrc :wq<cr>:source $MYVIMRC<cr>

" Useful macros for H and L
    noremap H <home>
    noremap L <end>

" Replace Escape with 'jk'
    inoremap jk <esc>

" Make searching easier
    nnoremap <leader>s :%s/\v
    nnoremap / /\v
    nnoremap ? ?\v
    nnoremap <leader>h :nohlsearch<cr>
    nnoremap <leader>* mz*`z
   
" Make delete work properly
"    inoremap <delete> <Esc>l"_xi

" Add "grep command"
"    nnoremap <leader>g :grep -R '<cword>' .<cr>
" F*** DOS!
" Had to remove this because of it's awful name
"   nnoremap <leader>fix-nl :%s/\v\r\n/<C-v><cr>/g<cr>:%s/\v\r/<C-v><cr>/g<cr>
" Implement C's main
    nnoremap <leader>cmain i#include <lt>stdlib.h><cr>#include <lt>stddef.h><cr>#include <lt>string.h><cr>#include <lt>stdio.h><cr><cr>int main(int argc, char* argv[]) {<cr>
" Make it easier to type commands
    noremap ; :
" Add line to top of file
    nnoremap <leader>u "xddmxgg:let g:my_search_cache = @/<cr>/\v^\s*$<cr>"xP:let @/ = g:my_search_cache<cr>'x
" Break long lines
    nnoremap <leader>k <home>gqj
" Choose whether the mouse is active
    nnoremap <leader>m :set mouse=a<cr>
    nnoremap <leader>M :set mouse-=a<cr>
" Spell stuff
    nnoremap <leader>z :silent! normal! z=1<cr><cr>
    nnoremap zq zg
" Pure awesomeness " Dosen't work :(
"    vnoremap <leader>g :call b:TheGoogleFunction(1)<cr>
" Unite bindings
	nnoremap <leader>f :<C-u>Unite -no-split file<CR>
	nnoremap <leader>F :<C-u>Unite -no-split -start-insert file<CR>
	nnoremap <leader>sf :split<cr>:<C-u>Unite -no-split file<CR>
	nnoremap <leader>sF :split<cr>:<C-u>Unite -no-split -start-insert file<CR>
" Easy fugitive
    nnoremap <leader>g :G
" }}}

" User-defined commands {{{
command! Eimacs call s:FixEimacs()
command! -nargs=1 Doc !man <args>

" }}}

" Common spelling errors {{{
    iabbrev U8Uint U8Unit
    iabbrev U16Uint U16Unit
    iabbrev esle else
    iabbrev tehn then
    iabbrev functino function
    iabbrev funtion function
    iabbrev funciton function
    iabbrev inoreamp inoremap
    iabbrev nnoreamp nnoremap
    iabbrev ehco echo
    iabbrev yeild yield
    iabbrev inlcude include
if &filetype ==# 'c'
    iabbrev INclude include
    iabbrev Include include
    iabbrev defien define
    iabbrev Define define
    iabbrev DEfine define
endif
    iabbrev iabberv iabbrev
    iabbrev Ture True
    iabbrev Flase False
    iabbrev ture true
    iabbrev flase false
    iabbrev incldeu include
    iabbrev iclude include
    iabbrev strutc struct
    iabbrev colsole console
    iabbrev objetc object
    iabbrev Objetc Object
" }}}

" augroups {{{
augroup filetype_vim " {{{
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
"    autocmd FileType vim call s:MakeGooglingFunction("vimscript")
    autocmd FileType coffee command! -nargs=1 Doc help <args>
augroup END " }}}

augroup filetype_c " {{{
    autocmd!
    autocmd FileType c setlocal number
"   autocmd FileType c setlocal keywordprg=/home/samtheman/code/junk/cman
"   autocmd FileType c split %:t:r.h
"    autocmd FileType c call s:MakeGooglingFunction("c")
    autocmd FileType c iabbrev Include include
    autocmd FileType c command! -nargs=1 Doc !man 3 <args>
    autocmd FileType c let $MANSECT = "3:2:3posix:3ncurses:1:n:l:8:3pm:3perl:5:4:9:6:7"
augroup END " }}}

augroup filetype_coffee " {{{
    autocmd!
    autocmd FileType coffee setlocal keywordprg=nodedoc
    autocmd FileType coffee setlocal foldmethod=indent
"    autocmd FileType coffee call s:MakeGooglingFunction("coffeescript")
    autocmd FileType coffee command! -nargs=1 Doc !nodedoc <args>
augroup END " }}}

augroup filetype_livescript " {{{
    autocmd!
    autocmd FileType ls setlocal keywordprg=nodedoc
    autocmd FileType ls setlocal foldmethod=indent
"    autocmd FileType ls call s:MakeGooglingFunction("livescript")
    autocmd FileType ls command! -nargs=1 Doc !nodedoc <args>
augroup END " }}}

augroup filetype_python " {{{
    autocmd!
    autocmd FileType python setlocal keywordprg=pydoc3
"    autocmd FileType python call s:MakeGooglingFunction("python 3")
    autocmd FileType python command! -nargs=1 Doc !pydoc3 <args>
    autocmd FileType python Python3Syntax
augroup END " }}}

autocmd BufRead,BufNewFile *.inc setl filetype=c

" }}}

"if !exists("b:TheGoogleFunction")
"    call g:MakeGooglingFunction("")
"endif
