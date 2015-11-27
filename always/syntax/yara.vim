" Vim syntax file
" Language: yara

if exists("b:current_syntax")
    finish
endif

let b:current_syntax = "yara"

sy keyword yaraKeys all and any ascii at condition for in entrypoint 
            \ filesize fullword global import include int8 int16 int32
            \ int8be int16be int32be matches meta nocase not or of private
            \ rule strings them uint8 uint16 uint32 uint8be uint16be
            \ uint32be wide
sy match yaraKeys /\v<contains>/

sy keyword yaraBool true false 

sy match yaraStringId /\v\$[a-zA-Z0-9_]+/

sy region yaraString start=/\v"/ end=/\v"/ contains=yaraEscape

sy match yaraEscape /\v\\["\\tn]/
sy match yaraEscape /\v\\x[a-fA-F0-9]{2}/

let s:hexRegex = '\v'. '\{'. 
            \ '('.
            \    '\s*'.
            \    '('.
            \       '[A-Fa-f0-9?]+'.
            \    '|'.
            \       '\['.
            \       '('.
            \          '[0-9]+-?[0-9]*'.
            \       '|'.
            \          '-[0-9]*'.
            \       ')'.
            \       '\]'.
            \    '|'.
            \       '[()|]'.
            \    ')'.
            \ ')+'.
            \ '\s*'.
            \ '\}'

execute "sy match yaraHex /" . s:hexRegex . "/"

"sy match yaraHex /\v\{(\s*([A-Fa-f0-9?]+|\[([0-9]+-?[0-9]*|-[0-9]+?)\]))+\s*\}/

sy region yaraComment start=+\V/*+ end=+\V*/+
sy match yaraComment +//.*$+

sy region yaraRegex start=+\v/+ end=+\v/+ contains=yaraMetaChars,yaraCharClass
sy match yaraMetaChars /\v[\\^$|()*+?{}]/ contained
sy region yaraCharClass start=/\v\[/ end=/\v\]/

hi link yaraRegex String
hi link yaraMetaChars operator
hi link yaraCharClass Identifier

hi link yaraEscape Special
hi link yaraComment Comment
hi link yaraHex String
hi link yaraString String
hi link yaraStringId Identifier
hi link yaraKeys Constant
hi link yaraKeys Keyword
