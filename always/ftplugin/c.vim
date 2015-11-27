setlocal number
" setlocal keywordprg=/home/samtheman/code/junk/cman
" split %:t:r.h
" call s:MakeGooglingFunction("c")
iabbrev Include include
command! -nargs=1 Doc !man 3 <args>
let $MANSECT = "3:2:3posix:3ncurses:1:n:l:8:3pm:3perl:5:4:9:6:7"
iabbrev INclude include
iabbrev Include include
iabbrev Define define
iabbrev DEfine define
