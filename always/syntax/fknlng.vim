" Vim Syntax File
" Language: fknlng

if exists("b:current_syntax") 
    finish
endif

syn region flLineUnit matchgroup=Todo start="\v^\*+" end="\v^\*@=" transparent

" syn match flLineBegin "\v^\**"

syn match flNMark "\v#" contained
syn match flVMark "\v\$" contained
syn match flCMark "\v\%" contained

syn keyword flFimm fimm nextgroup=flFimmFN

syn match flFimmFN "\v[-a-z0-9~!@#$%^&*()_+=`{}|\\:;\'\"?/<>,.]+" nextgroup=flType

syn keyword flKeywords fretv fcal fseta fgeta

syn keyword flStdTypes b s i l vl fp df t i8 i16 i32 i64 z o r contained
syn keyword flStdFuncs x + / % - ind ind= rnd p w gl gch gc gb sr ex ol contained
syn keyword flStdFuncs ss sc sj s+ scc srm contained
syn keyword flStdVars stdin stdout stderr stdlog argv bmx bmn smx smn imx imn contained
syn keyword flStdVars lmax lmin vlmx vlmn fpmx fpmn fpamx fpamn dfmax dfmin contained
syn keyword flStdVars tmx tmn tamx tamn i8mx i16mx i32mx zmxcc contained

syn match flNumber "\v#n?[0-9]+(\.[0-9]+)?(e[-+]?[0-9]+)?" contains=flNMark
syn match flNumber "\v#n?x[0-9a-f]+" contains=flNMark
syn match flNumber "\v#n?b[0-1]+" contains=flNMark
syn match flNumber "\v#n?o[0-7]+" contains=flNMark

syn match flVar "\v\$[-a-z0-9~!@#$%^&*()_+=`{}|\\:;\'\"?/<>,.]+" contains=flVMark,flStdVars,flStdFuncs
syn match flCall "\v\%[-a-z0-9~!@#$%^&*()_+=`{}|\\:;\'\"?/<>,.]+" nextgroup=flArg contains=flCMark,flStdFuncs
syn region flArg start="\v\[" end="\v\]" contained transparent nextgroup=flArg

syn match flDecl "\v\." nextgroup=flType

syn match flType "\v[-a-z0-9~!@#$%^&*()_+=`{}|\\:;\'\"?/<>,.]+" contained contains=flStdTpyes

let b:current_syntax = "fknlng"

hi link flLineBegin Todo
hi link flKeywords Keyword

hi link flNumber Number
hi link flVar Identifier
hi link flCall Function

hi link flNMark Special
hi link flVMark Special
hi link flCMark Special

hi link flStdTypes Statement
hi link flStdFuncs Statement
hi link flStdVars Statement

hi link flDecl Statement
hi link flType Type

hi link flFimm Statement
hi link flFimmFN Function
