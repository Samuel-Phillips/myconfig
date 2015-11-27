if &ft ==# 'cpp'
    finish
endif

sy keyword cOperator AND OR NOT DEC INC

sy region gnuCStatExpr matchgroup=delimiter start=/\V({/ end=/\V})/ transparent

let b:SPCHeaders = {}

func! s:HasHdr(name)
    return match(s:Content, '#include <'.a:name.'>') >= 0
endfunc

func! s:ExecHdr(name)
    if has_key(b:SPCHeaders, a:name)
        let l:hdr = b:SPCHeaders[a:name]
        unlet b:SPCHeaders[a:name]
        if len(l:hdr.funcs) > 0
            execute 'syntax keyword mycPreFuncs '.join(l:hdr.funcs, ' ')
        endif
        if len(l:hdr.types) > 0
            execute 'syntax keyword mycPreTypes '.join(l:hdr.types, ' ')
        endif
        if len(l:hdr.cnsts) > 0
            execute 'syntax keyword mycPreCnsts '.join(l:hdr.cnsts, ' ')
        endif
        for inc in get(hdr, 'includes', [])
            call s:ExecHdr(inc)
        endfor
    endif
endfunc

func! s:FailHdr(name)
    if has_key(b:SPCHeaders, a:name)
        let l:hdr = b:SPCHeaders[a:name]
        execute 'sy keyword mycNeedHdr '.join(l:hdr.funcs, ' ').' '.
                    \ join(l:hdr.types, ' ').' '.
                    \ join(l:hdr.cnsts, ' ')
    endif
endfunc


func! b:AfterSyntaxCBySamuelPhillipsReloadSyntax()
    let s:Content = getline(1,40)
    let b:SPCHeaders = eval(join(
                \ readfile(glob('~/code/junk/c_std_lib.json')), ''))
    if filereadable('./local_includes.json')
        let l:localHeader = eval(join(
                    \ readfile(glob('./local_includes.json')), ''))
        for name in keys(l:localHeader)
            let b:SPCHeaders[name] = l:localHeader[name]
        endfor
    endif

    for hdr in keys(b:SPCHeaders)
        if s:HasHdr(hdr)
            call s:ExecHdr(hdr)
        endif
    endfor
    for hdr in keys(b:SPCHeaders)
        call s:FailHdr(hdr)
    endfor

endfunc
"sy keyword mycPreFuncs " continue here

"sy keyword mycPreFuncs

hi link mycPreFuncs Function
hi link mycPreTypes Type
hi link mycPreCnsts Constant
hi link mycNeedHdr Error

call b:AfterSyntaxCBySamuelPhillipsReloadSyntax()
command! ReloadSyntax call b:AfterSyntaxCBySamuelPhillipsReloadSyntax()

func! b:AfterSyntaxCBySamuelPhillipsGetHeader()
    mark z
    let l:tk = expand("<cword>")
    let l:header = b:GetHeaderHasObject(l:tk)
    if l:header ==# '/* Not found */'
        echom 'No header file for '.l:tk
    else
        execute 'normal! ggO#include <'.l:header.'>'
        echom 'Included '.l:header
        normal! `z
        call b:AfterSyntaxCBySamuelPhillipsReloadSyntax()
    endif
endfunc

func! b:GetHeaderHasObject(obj)
    if a:obj == 'bool'
        return 'stdbool.h'
    elseif a:obj == 'errno'
        return 'errno.h'
    endif
    for name in keys(b:SPCHeaders)
        let l:hdr = b:SPCHeaders[name]
        if index(hdr.funcs, a:obj) > 0
            return name
        elseif index(hdr.types, a:obj) > 0
            return name
        elseif index(hdr.cnsts, a:obj) > 0
            return name
        endif
    endfor
    return '/* Not found */'
endfunc

nnoremap <buffer> <leader>i :call b:AfterSyntaxCBySamuelPhillipsGetHeader()<cr>
