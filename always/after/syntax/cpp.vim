let s:contents = getline(1, 20)

let s:Headers = {}

if match(s:contents, '#include "macros.hpp"') >= 0
    sy keyword myCppKws def returns lambda
    sy match myCppTypes /\v<fp\s*::\s*(list|string|mapping|fun)>/
endif

func! s:Header(hname)
    return match(s:contents, '#include <'.a:hname.'>') >= 0
endfunc

func! s:Match(what, namespace, texts)
    execute 'sy match myCpp'.a:what.' /\v<'.a:namespace.'\s*::\s*('.
                \ join(a:texts, '|').')>/'
endfunc

func! s:MMatch(what, namespace, texts)
    execute 'sy match myCppM'.a:what.' /\v<'.a:namespace.'('.
                \ join(a:texts, '|').')>/'
endfunc

func! s:Register(myhdr)
    let s:Headers[a:myhdr] = function('s:Header_'.a:myhdr)
endfunc

func! s:Include(files)
    for l:file in a:files
        call s:Headers[l:file]()
        let  s:Headers[l:file] = function("s:DoNothing")
    endfor
endfunc

func! s:DoNothing()
endfunc

" Begin actual stuff

func! s:Header_initializer_list()
    call s:Match('Types', 'std', ['initializer_list'])
    call s:Match('Functions', 'std', ['begin', 'end'])
endfunc
call s:Register("initializer_list")

func! s:Header_iosfwd()
    call s:Match('Types', 'std', ['char_traits', 'allocator', 'basic_ios',
                \ 'fpos', 'basic_(stream|file|string)buf',
                \ 'basic_iostream', 'basic_[io]stream', 'basic_[io]?fstream',
                \ '(basic_)?[io]?stringstream', 'strstreambuf',
                \ 'w?streampos'])
endfunc
call s:Register("iosfwd")

func! s:Header_string()
    call s:Match('Types', 'std', ['char_traits', 'basic_string', 'string',
                \ 'u(16|32)string', 'hash'])
    call s:Match('Funcs', 'std', ['swap', 'sto(i|u?ll?|f|l?d)', 'to_w?string'])
    call s:Include(['initializer_list'])
endfunc
call s:Register("string")

func! s:Header_vector()
    call s:Match('Types', 'std', ['vector', 'hash'])
    call s:Match('Funcs', 'std', ['swap'])
    call s:Include(['initializer_list'])
endfunc
call s:Register("vector")

func! s:Header_iostream()
    call s:Match('Globals', 'std', ['w?cin', 'w?cout', 'w?cerr', 'w?clog'])
    call s:Include(['ios', 'streambuf', 'istream', 'ostream'])
endfunc
call s:Register("iostream")

func! s:Header_ios()
    call s:Match('Types', 'std', ['ios_base', 'basic_ios', 'fpos', 'io_errc',
                \ 'iostream_category', 'is_error_code_enum', 'streamoff',
                \ 'streamsize'])
    call s:Match('Funcs', 'std', ['make_error_co(de|ndition)'])
    call s:Match('Mods', 'std', ['(no)?boolalpha',
                \ '(no)?show(base|po(int|s))', '(no)?skipws', '(no)?uppercase',
                \ '(no)?unitbuf', 'internal', 'left', 'right', 'dec', 'hex',
                \ 'oct', 'fixed', 'scientific', 'hexfloat', 'defaultfloat'])
    call s:Include(['iosfwd'])
endfunc
call s:Register("ios")

func! s:Header_streambuf()
    call s:Match('Types', 'std', ['w?streambuf', 'basic_streambuf'])
endfunc
call s:Register("streambuf")

func! s:Header_istream()
    call s:Match('Types', 'std', ['basic_io?stream', 'w?io?stream'])
    call s:Match('Mods', 'std', ['ws'])
endfunc
call s:Register("istream")

func! s:Header_ostream()
    call s:Match('Types', 'std', ['basic_ostream', 'w?ostream'])
    call s:Match('Mods', 'std', ['ends', 'flush', 'endl'])
endfunc
call s:Register("ostream")

func! s:Header_fstream()
    call s:Match('Types', 'std', ['basic_filebuf', 'basic_[io]?fstream',
                \ 'w?filebuf', 'w?[io]?fstream'])
    call s:Match('Funcs', 'std', ['swap'])
endfunc
call s:Register("fstream")

func! s:Header_sstream()
    call s:Match('Types', 'std', ['basic_(stringbuf|[io]?stringstream)',
            \ 'w?stringbuf', 'w?[io]?stringstream'])
    call s:Match('Funcs', 'std', ['swap'])
endfunc
call s:Register("sstream")

func! s:Header_strstream()
    call s:Match('Types', 'std', ['strstreambuf', '[io]?strstream'])
endfunc
call s:Register("strstream")

func! s:Header_iomanip()
    call s:Match('Types', 'std', ['(re)?setiosflags',
                \ 'set(base|fill|precision|w)', '(get|put)_(money|time)'])
endfunc
call s:Register("iomanip")

func! s:Header_locale()
    call s:Match('Types', 'std', ['locale', 'w(string|buffer)_convert',
                \ '(ctype|codecvt|messages|time|money)_base',
                \ '(ctype|codecvt|collate|messages)(_byname)?',
                \ '(time|num|money)_(get|put)', '(num|money)punct(_byname)?',
                \ 'time_(put|get)_byname', '(num|money)punct_byname'])
    call s:Match('Funcs', 'std', ['isspace', 'isblank', 'iscntrl', 'isupper',
                \ 'islower', 'isalpha', 'isdigit', 'ispunct', 'isxdigit',
                \ 'isalnum', 'isprint', 'isgraph', 'toupper', 'tolower'])
endfunc
call s:Register("locale")

func! s:Header_codecvt()
    call s:Match('Types', 'std', ['codecvt_(utf(8|16|8_utf16)|mode)'])
endfunc
call s:Register("codecvt")

func! s:Header_regex()
    call s:Match('Types', 'std\s*::\s*regex_constants', ['syntax_option_type', 'match_flag_type',
                \ 'basic_regex', 'sub_match', 'match_results',
                \ 'regex_((token_)?iterator|error|traits)'])
    call s:Match('Funcs', 'std', ['regex_(match|search|replace)', 'swap'])
    call s:Match('Globals', 'std\s*::\s*regex_constants', [
                \ 'icase', 'nosubs', 'optimise', 'collate', 'ECMAScript',
                \ 'basic', 'extended', 'awk', 'grep', 'egerp', 
                \ 'match_(default|not_[be]o[lw]|any|not_null|continous)',
                \ 'match_prev_avail',
                \ 'format_(default|sed|no_copy|first_only',
                \ 'error_(collate|ctype|escape|backref|brack|paren|brace)',
                \ 'error_(badbrace|range|space|badrepeat|complexity|stack)'])
endfunc
call s:Register("regex")

func! s:Header_atomic()
    call s:Match('Types', 'std', ['atomic', 'atomic_flag', 'memory_order',
                \ 'atomic_(bool|[su]?char|'.
                \ 'u?(short|int(_(least|fast)(8|16|32)_t)?|l?long|intptr_t)|'.
                \ 'char(16|32)_t|wchar_t|size_t|ptrdiff_t|u?intmax_t)'])
    call s:Match('Funcs', 'std', ['atomic_(is_lock_free|'.
                \ '(store|load|compare_exchange|fetch_(add|sub|or|xor)|'.
                \ 'flag_(test_and_set|clear))(_explicit)?|init|'.
                \ '(thread|signal)_fence)'])
    call s:MMatch('Funcs', 'ATOMIC_', ['(VAR|FLAG)_INIT'])
endfunc
call s:Register("atomic")

func! s:Header_functional()
    call s:Match('Globals', 'std\s*::\s*placeholders', ['_[1-4]'])
    call s:Match('Types', 'std', ['function', 'mem_fn', 'bad_function_call',
                \ 'is_bind_expression', 'isplaceholder', 'reference_wrapper',
                \ 'hash'])
    call s:Match('Funcs', 'std', ['bind', 'ref', 'cref'])
    call s:Match('Globals', 'std', ['plus', 'minus', 'multiplies', 'divides',
                \ 'modulus', 'negate', '(not_)?equal_to',
                \ '(greater|less)(_equal)?', 'logical_(and|or|not)',
                \ 'bit_(and|x?or)', '(u|bi)nary_negate', 'not[12]'])
    call s:Match('Types', 'std', ['(u|bi)nary_function', 'bind(er)?(1st|2nd)',
                \ 'pointer_to_(u|bi)nary_function',
                \ '(const_)?mem_fun1?(_ref)?_t', 'mem_fun_ref'])
    call s:Match('Funcs', 'std', ['(mem|ptr)_fun'])
endfunc
call s:Register('functional')

func! s:Header_chrono()
    call s:Match('Types', 'std\s*::\s*chrono', ['duration', 'system_clock',
                \ 'steady_clock', 'high_resolution_clock', 'time_point',
                \ 'treat_as_floationg_point', 'duration_values', 'common_type'])
    call s:Match('Types', 'std\s*::\s*chrono', ['(nano|micro|milli)?seconds',
                \ 'minutes', 'hours'])
    call s:Match('Funcs', 'std\s*::\s*chrono', ['duration_cast',
                \ 'time_point_cast'])
endfunc
call s:Register('chrono')

func! s:Header_cstdlib()
    call s:MMatch('Globals', '', ['EXIT_(SUCCESS|FAILURE)', 'MB_CUR_MAX',
                \ 'NULL', 'RAND_MAX'])
    call s:Match('Types', 'std', ['div_t', 'ldiv_t', 'lldiv_t', 'size_t'])
    call s:Match('Funcs', 'std', ['abort', 'exit', 'quick_exit', '_Exit',
                \ 'atexit', 'at_quick_exit', 'system', 'getenv', 'malloc',
                \ 'calloc', 'realloc', 'free', 'ato([fil]|ll)',
                \ 'strto(u?ll?|f|l?d)', 'mblen', 'mbtowc', 'wctomb', 'mbstowcs',
                \ 'wcstombs', 'rand', 'srand', 'qsort', 'bsearch', 'abs',
                \ 'l?labs', 'div', 'l?ldiv'])
endfunc
call s:Register('cstdlib')

func! s:Header_csignal()
    call s:Match('Types', 'std', ['sig_atomic_t'])
    call s:MMatch('Globals', 'SIG', ['ABRT', 'FPE', 'ILL', 'INT', 'SEGV',
                \ 'TERM', '_DFL', '_ERR'])
    call s:Match('Funcs', 'std', ['signal', 'raise'])
endfunc
call s:Register('csignal')

func! s:Header_utility()
    call s:Match('Funcs', 'std', ['swap', 'forward', 'move(_if_noexcept)?',
                \ 'declval', 'make_pair', 'get'])
    call s:Match('Types', 'std', ['pair', 'piecewise_construct_t',
                \ 'integer_sequence', 'tuple'])
    call s:Match('Globals', 'std', ['piecewise_construct'])
    call s:Include('initializer_list')
endfunc
call s:Register('utility')

func! s:Header_new()
    call s:Match('Types', 'std', ['bad_a(lloc|rray_new_length)', 'nothrow_t',
                \ 'new_handler'])
    call s:Match('Funcs', 'std', ['(get|set)_new_handler'])
    call s:Match('Globals', 'std', ['nothrow'])
endfunc
call s:Register('new')

func! s:Header_memory()
    call s:Match('Types', 'std', ['(unique|shared|weak|auto)_ptr', 'owner_less',
                \ 'enable_shared_from_this', 'bad_weak_ptr', 'default_delete',
                \ 'allocator_(traits|arg(_t)?)', 'uses_allocator', 
                \ 'pointer_(safety|traits)', 'hash'])
    call s:Match('Funcs', 'std', ['uninitialized_(copy|fill)(_n)?',
                \ 'raw_storage_iterator', '(get|return)_temporary_buffer',
                \ '(un)?declare_(reachable|no_pointers)', 'get_pointer_safety',
                \ 'addressof', 'align', 'make_shared', 'allocate_shared',
                \ '(static|dynamic|const)_pointer_cast', 'get_deleter', 'swap'])
    call s:Match('Globals', 'std', ['allocator_arg'])
endfunc
call s:Register('memory')

func! s:Header_scoped_allocator()
    call s:Match('Types', 'std', ['scoped_allocator_adaptor'])
endfunc
call s:Register('scoped_allocator')

func! s:Header_exception()
    call s:Match('Types', 'std', ['(nested_|bad_)?exception',
                \ 'unexpected(_handler)?', 'terminate_handler',
                \ 'exception_ptr'])
    call s:Match('Funcs', 'std', ['uncaught_exceptions?', 'make_exception_ptr',
                \ '(current|rethrow)_exception',
                \ '(throw_with|rethrow_if)_nested', '([gs]et_)?terminate',
                \ '[gs]et_unexpected'])
endfunc
call s:Register('exception')

func! s:Header_stdexcept()
    call s:Match('Types', 'std', ['(logic|domain|length|runtime|'.
                \ 'range|(ov|und)erflow)_error', 'invalid_argument',
                \ 'out_of_range'])
endfunc
call s:Register('stdexcept')

func! s:Header_cerrno()
    call s:MMatch('Vars', '', ['errno'])
    call s:MMatch('Globals', 'E', ['2BIG', 'ACCES', 'ADDRINUSE', 'ADDRNOTAVAIL',
                \ 'AFNOSUPPORT', 'AGAIN', 'ALREADY', 'BADF', 'BADMSG', 'BUSY',
                \ 'CANCELED', 'CHILD', 'CONN(ABORTED|REFUSED|RESET)', 'DEADLK',
                \ 'DESTADDRREQ', 'DOM', 'EXIST', 'FAULT', 'FBIG', 'HOSTUNREACH',
                \ 'IDRM', 'ILSEQ', 'INPROGRESS', 'INTR', 'INVAL', 'IO',
                \ 'ISCONN', 'ISDIR', 'LOOP', 'MFILE', 'MLINK', 'MSGSIZE',
                \ 'NAMETOOLONG', 'NETDOWN', 'NETRESET', 'NETUNREACH', 'NFILE',
                \ 'NO(BUFS|DATA|DEV|ENT|EXEC|LCK|LINK|MEM|MSG|PROTOOPT|SPC|SR|'.
                \ 'STR|SYS)', 'NOT(CONN|DIR|EMPTY|RECOVERABLE|SOCK|SUP|TTY)',
                \ 'OPNOTSUPP', 'OVERFLOW', 'OWNERDEAD', 'PERM', 'PIPE', 'PROTO',
                \ 'PROTONOSUPPORT', 'PROTOTYPE', 'RANGE', 'ROFS', 'SPIPE',
                \ 'SRCH', 'TIME', 'TIMEDOUT', 'WOULDBLOCK', 'XDEV', 'NXIO'])
endfunc
call s:Register('cerrno')

func! s:Header_algorithm()
    call s:Match('Funcs', 'std', ['(all|any|none)_of', 'for_each',
                \ 'count(_if)?', 'mismatch', 'equal',
                \ 'find(_if(_not)?|_first_of|_end)?', 'adjacent_find',
                \ 'search(_n)?', 'copy(_if|_n|_backward)?', 'move(_backward)?',
                \ 'fill(_n)?', 'transform', 'generate(_n)?',
                \ '(remove|replace)(_copy)?(_if)?', 'swap(_ranges)?',
                \ 'iter_swap', '(reverse|rotate)(_copy)?', '(random_)?shuffle',
                \ 'unique(_copy)?', 'is_partitioned', 'stable_partition',
                \ 'partition(_copy|_point)?', 'is_sorted(_until)?', 'sort',
                \ 'partial_sort(_copy)?', 'stable_sort', 'nth_element',
                \ '(low|upp)er_bound', 'binary_search', 'equal_range',
                \ '(inplace_)?merge', 'includes',
                \ 'set_((symmetric_)?difference|intersection|union)',
                \ 'is_heap(_until)?', '(make|push|pop|sort)_heap',
                \ '(min|max|minmax)(_element)?', 'lexicographical_compare',
                \ '(is|next|prev)_permutation'])
endfunc
call s:Register('algorithm')

func! s:Header_iterator()
    call s:Match('Types', 'std', ['iteratior(_traits)?', '(input|output|'.
                \ 'forward|bidirectional|random)_iteratior_tag',
                \ '(reverse|move|(back|front)_insert|[io]stream(buf)?)'.
                \ '_iterator'])
    call s:Match('Funcs', 'std', ['make_move_iterator',
                \ '(front_|back_)?inserter', 'advance', 'distance', 'next',
                \ 'prev', '(c|cr)?(begin|end)'])
endfunc
call s:Register('iterator')

func! s:Header_random()
    call s:Match('Types', 'std', ['(linear_congruential|mersenne_twister|'.
                \ 'subtract_with_carry|discard_block|independant_bits|'.
                \ 'shuffle_order)_engine', 'seed_seq',
                \ 'minstd_rand0?', 'mt19937(_64)?', 'ranlux(24|48)(_base)?',
                \ 'knuth_b', 'default_random_engine',
                \ 'uniform_(int|real)_distribution',
                \ '(bernoulli|(negative_)?binomial|negative|geometric|'.
                \ 'poisson|exponential|gamma|weibull|extreme_value|normal|'.
                \ 'lognormal|chi_squared|cauchy|fisher_f|student_t|discrete|'.
                \ 'piecewise_(constant|linear))_distribution'])
    call s:Match('Funcs', 'std', ['generate_canonical'])
endfunc
call s:Register('random')

" End

for item in keys(s:Headers)
    if s:Header(item)
        call s:Headers[item]()
        let  s:Headers[item] = function("s:DoNothing")
    endif
endfor


hi link myCppKws Keyword
hi link myCppTypes Type
hi link myCppFuncs Function
hi link myCppGlobals Constant
hi link myCppMods Constant

hi link myCppMKws PreProc
hi link myCppMTypes Type
hi link myCppMFuncs Function
hi link myCppMGlobals Constant
hi link myCppMMods Constant
hi link myCppMVars Identifier
