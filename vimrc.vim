" Start on a high note
"  execute pathogen#infect()
" Nope, we have vim-plug now


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
