setlocal keywordprg=nodedoc
setlocal foldmethod=indent
" call s:MakeGooglingFunction("coffeescript")
command! -nargs=1 Doc !nodedoc <args>
