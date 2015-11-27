setlocal keywordprg=pydoc3
" call s:MakeGooglingFunction("python 3")
command! -nargs=1 Doc !pydoc3 <args>
