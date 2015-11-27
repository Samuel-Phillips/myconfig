setlocal keywordprg=nodedoc
setlocal foldmethod=indent
" call s:MakeGooglingFunction("livescript")
command! -nargs=1 Doc !nodedoc <args>
