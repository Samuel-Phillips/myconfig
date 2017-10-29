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

function! s:insert_gates(cplusplus)
    let l:gatename = 'INCLUDE_GUARD_' .
    \   pyeval('"%0.32X" % __import__("random").randrange(1, 1<<128)')

    call append(0, [
    \       "#ifndef " . l:gatename,
    \       "#define " . l:gatename
    \   ])

    call append(line('$'), [
    \       "#endif /* !defined " . gatename . " */"
    \   ])
endfunction

autocmd BufNewFile *.hpp call <SID>insert_gates(1)
autocmd BufNewFile *.h call <SID>insert_gates(0)
