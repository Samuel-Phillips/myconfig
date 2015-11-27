" Vim syntax file
" Language: myl

if exists("b:current_syntax")
    finish
endif

syn keyword mylSet set nextgroup=mylDecl
syn keyword mylStat return

syn region mylImport matchgroup=Include start="\v^\s*import\W@=" end="\v\n"

syn match mylDecl '\V\w\+' contained

" syn region mylExpr start='\V(' end='\V(' transparent
syn keyword mylStdFuncs for if while else with sum diff mul split ref
syn keyword mylStdFuncs unref jump mark switch address
syn keyword mylStdTypes List Num Int Dec Str Bin Table Func
syn keyword mylStdTypes ArrayList LinkedList
syn keyword mylStdTypes Int8 Int16 Int32 Int64 IntInf
syn keyword mylStdTypes Dec1 Dec2 Dec3 DecInf
syn keyword mylStdTypes Utf8Unit FullChar
syn keyword mylStdTypes HashTable
syn keyword mylStdTypes FuncHard FuncSoft
syn keyword mylStdTypes Type Obj
syn keyword mylStdVar stdin stdout stderr module true false null

syn region mylComment start='\v# ' end='\n'
syn region mylComment start='\v#\[' end='\v\['
syn region mylCommentDoc start='\v##' end='\v\n' contains=mylCDTag,mylCDEnt

syn region mylCDTag matchgroup=SpecialComment start='<' end='>' contained contains=mylCDNames,mylCDProps,mylStr
syn  keyword mylCDNames em strong span div link h1 h2 h3 p ul ol li dl dt contained
syn  keyword mylCDNames dd retv tname code ident args arg contained
syn  keyword mylCDProps ref style type contained
syn region mylCDEnt start='&' end=';' contained

syn match mylNumber '\W\@<=\d\+'
syn match mylNumber '\W\@<=[-+]\d\+'
syn match mylNumber '\W\@<=\d\+\.\d*'
syn match mylNumber '\W\@<=[-+]\d\+\.\d*'
syn match mylNumber '\W\@<=[-+]\=\d[[:digit:]]*[eE][\-+]\=\d\+'
syn match mylNumber '\W\@<=\d[[:digit:]]*[eE][\-+]\=\d\+'
syn match mylNumber '\W\@<=[-+]\=\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+'
syn match mylNumber '\W\@<=\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+'


syn region mylStr start='"' end='"' contains=mylStrEsc,mylStrF,mylStrF2

syn match mylStrEsc "\v\\[rnts0123456789abcdef'"]" 
syn region mylStrF matchgroup=SpecialChar start='$(' end=')' contained
syn region mylStrF2 matchgroup=SpecialChar start='\v$\(@!' end='\v\W@=' contained

let b:current_syntax = "myl"

hi def link mylImport Constant

hi def link mylSet Statement
hi def link mylStat Statement
hi def link mylStdFuncs Function
hi def link mylStdTypes Type

hi def link mylStr String
hi def link mylStrEsc SpecialChar

hi def link mylDecl Identifier
hi def link mylNumber Number
hi def link mylStdVar Identifier

hi def link mylComment Comment
hi def link mylCommentDoc Comment

hi def link mylCDNames Constant
hi def link mylCDEnt SpecialComment
hi def link mylCDProps SpecialComment
