" Vim syntax file
" Language: Scheme (R5RS)
" Maintainer: Taylor Venable <taylor@metasyntax.net>
"     (forked from Sergey Khorev <sergey.khorev@gmail.com>)
" Original: Dirk van Deun <dirk@igwe.vub.ac.be>
" Last Change:  2010-06-17
" Version:  r639
" URL:    http://bitbucket.org/taylor_venable/metasyntax/src/tip/Config/vim/syntax/scheme.vim

" This script incorrectly recognizes some junk input as numerals:
" parsing the complete system of Scheme numerals using the pattern
" language is practically impossible: I did a lax approximation.

" MzScheme extensions can be activated with setting is_mzscheme variable

" Suggestions and bug reports are solicited by the author.

" Initializing:

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case ignore

" Fascist highlighting: everything that doesn't fit the rules is an error...

syn match schemeError ![^ \t()\[\]";]*!
syn match schemeError ")"

syn region schemeSexp start='(' end=')' contained transparent contains=schemeSexp

" Quoted and backquoted stuff

syn region schemeQuoted matchgroup=Delimiter start="['`]" end=![ \t()\[\]";]!me=e-1 contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc

syn region schemeQuoted matchgroup=Delimiter start="['`](" matchgroup=Delimiter end=")" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc
syn region schemeQuoted matchgroup=Delimiter start="['`]#(" matchgroup=Delimiter end=")" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc

syn region schemeStrucRestricted matchgroup=Delimiter start="(" matchgroup=Delimiter end=")" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc
syn region schemeStrucRestricted matchgroup=Delimiter start="#(" matchgroup=Delimiter end=")" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc

" Popular Scheme extension:
" using [] as well as ()
syn region schemeStrucRestricted matchgroup=Delimiter start="\[" matchgroup=Delimiter end="\]" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc
syn region schemeStrucRestricted matchgroup=Delimiter start="#\[" matchgroup=Delimiter end="\]" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc

syn region schemeUnquote matchgroup=Delimiter start="," end=![ \t\[\]()";]!me=e-1 contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc
syn region schemeUnquote matchgroup=Delimiter start=",@" end=![ \t\[\]()";]!me=e-1 contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc

syn region schemeUnquote matchgroup=Delimiter start=",(" end=")" contains=ALL
syn region schemeUnquote matchgroup=Delimiter start=",@(" end=")" contains=ALL

syn region schemeUnquote matchgroup=Delimiter start=",#(" end=")" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc
syn region schemeUnquote matchgroup=Delimiter start=",@#(" end=")" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc

syn region schemeUnquote matchgroup=Delimiter start=",\[" end="\]" contains=ALL
syn region schemeUnquote matchgroup=Delimiter start=",@\[" end="\]" contains=ALL

syn region schemeUnquote matchgroup=Delimiter start=",#\[" end="\]" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc
syn region schemeUnquote matchgroup=Delimiter start=",@#\[" end="\]" contains=ALLBUT,schemeStruc,schemeSyntax,schemeFunc

" R5RS Scheme Functions and Syntax:

if version < 600
  set iskeyword=33,35-39,42-58,60-90,94,95,97-122,126,_
else
  setlocal iskeyword=33,35-39,42-58,60-90,94,95,97-122,126,_
endif

syn keyword schemeSyntax lambda and or if cond case define let let* letrec
syn keyword schemeSyntax begin do delay set! else =>
syn keyword schemeSyntax quote quasiquote unquote unquote-splicing
syn keyword schemeSyntax define-syntax let-syntax letrec-syntax syntax-rules

syn keyword schemeFunc not boolean? eq? eqv? equal? pair? cons car cdr set-car!
syn keyword schemeFunc set-cdr! caar cadr cdar cddr caaar caadr cadar caddr
syn keyword schemeFunc cdaar cdadr cddar cdddr caaaar caaadr caadar caaddr
syn keyword schemeFunc cadaar cadadr caddar cadddr cdaaar cdaadr cdadar cdaddr
syn keyword schemeFunc cddaar cddadr cdddar cddddr null? list? list length
syn keyword schemeFunc append reverse list-ref memq memv member assq assv assoc
syn keyword schemeFunc symbol? symbol->string string->symbol number? complex?
syn keyword schemeFunc real? rational? integer? exact? inexact? = < > <= >=
syn keyword schemeFunc zero? positive? negative? odd? even? max min + * - / abs
syn keyword schemeFunc quotient remainder modulo gcd lcm numerator denominator
syn keyword schemeFunc floor ceiling truncate round rationalize exp log sin cos
syn keyword schemeFunc tan asin acos atan sqrt expt make-rectangular make-polar
syn keyword schemeFunc real-part imag-part magnitude angle exact->inexact
syn keyword schemeFunc inexact->exact number->string string->number char=?
syn keyword schemeFunc char-ci=? char<? char-ci<? char>? char-ci>? char<=?
syn keyword schemeFunc char-ci<=? char>=? char-ci>=? char-alphabetic? char?
syn keyword schemeFunc char-numeric? char-whitespace? char-upper-case?
syn keyword schemeFunc char-lower-case?
syn keyword schemeFunc char->integer integer->char char-upcase char-downcase
syn keyword schemeFunc string? make-string string string-length string-ref
syn keyword schemeFunc string-set! string=? string-ci=? string<? string-ci<?
syn keyword schemeFunc string>? string-ci>? string<=? string-ci<=? string>=?
syn keyword schemeFunc string-ci>=? substring string-append vector? make-vector
syn keyword schemeFunc vector vector-length vector-ref vector-set! procedure?
syn keyword schemeFunc apply map for-each call-with-current-continuation
syn keyword schemeFunc call-with-input-file call-with-output-file input-port?
syn keyword schemeFunc output-port? current-input-port current-output-port
syn keyword schemeFunc open-input-file open-output-file close-input-port
syn keyword schemeFunc close-output-port eof-object? read read-char peek-char
syn keyword schemeFunc write display newline write-char call/cc
syn keyword schemeFunc list-tail string->list list->string string-copy
syn keyword schemeFunc string-fill! vector->list list->vector vector-fill!
syn keyword schemeFunc force with-input-from-file with-output-to-file
syn keyword schemeFunc char-ready? load transcript-on transcript-off eval
syn keyword schemeFunc dynamic-wind port? values call-with-values
syn keyword schemeFunc scheme-report-environment null-environment
syn keyword schemeFunc interaction-environment

" ... so that a single + or -, inside a quoted context, would not be
" interpreted as a number (outside such contexts, it's a schemeFunc)

syn match schemeDelimiter !\.[ \t\[\]()";]!me=e-1
syn match schemeDelimiter !\.$!
" ... and a single dot is not a number but a delimiter

" This keeps all other stuff unhighlighted, except *stuff* and <stuff>:

syn match schemeOther ,[a-z!$%&*/:<=>?^_~+@#%-][-a-z!$%&*/:<=>?^_~0-9+.@#%]*,
"syn match  schemeError ,[a-z!$%&*/:<=>?^_~+@#%-][-a-z!$%&*/:<=>?^_~0-9+.@#%]*[^-a-z!$%&*/:<=>?^_~0-9+.@ \t\[\]()";]\+[^ \t\[\]()";]*,

syn match schemeOther "\.\.\."
syn match schemeError !\.\.\.[^ \t\[\]()";]\+!
" ... a special identifier

syn match schemeConstant  ,\*[-a-z!$%&*/:<=>?^_~0-9+.@]*\*[ \t\[\]()";],me=e-1
syn match schemeConstant  ,\*[-a-z!$%&*/:<=>?^_~0-9+.@]*\*$,
syn match schemeError ,\*[-a-z!$%&*/:<=>?^_~0-9+.@]*\*[^-a-z!$%&*/:<=>?^_~0-9+.@ \t\[\]()";]\+[^ \t\[\]()";]*,

syn match schemeConstant  ,<[-a-z!$%&*/:<=>?^_~0-9+.@]*>[ \t\[\]()";],me=e-1
syn match schemeConstant  ,<[-a-z!$%&*/:<=>?^_~0-9+.@]*>$,
syn match schemeError ,<[-a-z!$%&*/:<=>?^_~0-9+.@]*>[^-a-z!$%&*/:<=>?^_~0-9+.@ \t\[\]()";]\+[^ \t\[\]()";]*,

syn match schemeConstant  ,+[-a-z!$%&*/:<=>?^_~0-9+.@]*+[ \t\[\]()";],me=e-1
syn match schemeConstant  ,+[-a-z!$%&*/:<=>?^_~0-9+.@]*+$,
syn match schemeError ,+[-a-z!$%&*/:<=>?^_~0-9+.@]*+[^-a-z!$%&*/:<=>?^_~0-9+.@ \t\[\]()";]\+[^ \t\[\]()";]*,

" Non-quoted lists, and strings:

syn region schemeStruc matchgroup=Delimiter start="(" matchgroup=Delimiter end=")" contains=ALL
syn region schemeStruc matchgroup=Delimiter start="#(" matchgroup=Delimiter end=")" contains=ALL

syn region schemeStruc matchgroup=Delimiter start="\[" matchgroup=Delimiter end="\]" contains=ALL
syn region schemeStruc matchgroup=Delimiter start="#\[" matchgroup=Delimiter end="\]" contains=ALL

" Simple literals:
syn region schemeString start=+\%(\\\)\@<!"+ skip=+\\[\\"]+ end=+"+

" Comments:

syn match schemeComment ";.*$"


" Writing out the complete description of Scheme numerals without
" using variables is a day's work for a trained secretary...

syn match schemeOther ![+-][ \t\[\]()";]!me=e-1
syn match schemeOther ![+-]$!
"
" This is a useful lax approximation:
syn match schemeNumber  "[-#0-9.][-#/0-9a-f@i.boxesfdl]*"
syn match schemeError ![-#0-9.][-#/0-9a-f@i.boxesfdl]*[^-#/0-9a-f@i.boxesfdl \t\[\]()";][^ \t\[\]()";]*!

syn match schemeBoolean "#[tf]"
syn match schemeError !#[tf][^ \t\[\]()";]\+!

syn match schemeChar  "#\\"
syn match schemeChar  "#\\."
"syn match       schemeError  !#\\.[^ \t\[\]()";]\+!
syn match schemeChar  "#\\space"
syn match schemeError !#\\space[^ \t\[\]()";]\+!
syn match schemeChar  "#\\newline"
syn match schemeError !#\\newline[^ \t\[\]()";]\+!

if exists("b:is_mzscheme") || exists("is_mzscheme")
    " MzScheme extensions
    " multiline comment
    syn region  schemeComment start="#|" end="|#"

    " #%xxx are the special MzScheme identifiers
    syn match schemeOther "#%[-a-z!$%&*/:<=>?^_~0-9+.@#%]\+"
    " anything limited by |'s is identifier
    syn match schemeOther "|[^|]\+|"

    syn match schemeChar  "#\\\%(return\|tab\)"

    " Modules require stmt
    syn keyword schemeExtSyntax module require dynamic-require lib prefix all-except prefix-all-except rename
    " modules provide stmt
    syn keyword schemeExtSyntax provide struct all-from all-from-except all-defined all-defined-except
    " Other from MzScheme
    syn keyword schemeExtSyntax with-handlers when unless instantiate define-struct case-lambda syntax-case
    syn keyword schemeExtSyntax free-identifier=? bound-identifier=? module-identifier=? syntax-object->datum
    syn keyword schemeExtSyntax datum->syntax-object
    syn keyword schemeExtSyntax let-values let*-values letrec-values set!-values fluid-let parameterize begin0
    syn keyword schemeExtSyntax error raise opt-lambda define-values unit unit/sig define-signature 
    syn keyword schemeExtSyntax invoke-unit/sig define-values/invoke-unit/sig compound-unit/sig import export
    syn keyword schemeExtSyntax link syntax quasisyntax unsyntax with-syntax

    syn keyword schemeExtFunc format system-type current-extension-compiler current-extension-linker
    syn keyword schemeExtFunc use-standard-linker use-standard-compiler
    syn keyword schemeExtFunc find-executable-path append-object-suffix append-extension-suffix
    syn keyword schemeExtFunc current-library-collection-paths current-extension-compiler-flags make-parameter
    syn keyword schemeExtFunc current-directory build-path normalize-path current-extension-linker-flags
    syn keyword schemeExtFunc file-exists? directory-exists? delete-directory/files delete-directory delete-file
    syn keyword schemeExtFunc system compile-file system-library-subpath getenv putenv current-standard-link-libraries
    syn keyword schemeExtFunc remove* file-size find-files fold-files directory-list shell-execute split-path
    syn keyword schemeExtFunc current-error-port process/ports process printf fprintf open-input-string open-output-string
    syn keyword schemeExtFunc get-output-string
    " exceptions
    syn keyword schemeExtFunc exn exn:application:arity exn:application:continuation exn:application:fprintf:mismatch
    syn keyword schemeExtFunc exn:application:mismatch exn:application:type exn:application:mismatch exn:break exn:i/o:filesystem exn:i/o:port
    syn keyword schemeExtFunc exn:i/o:port:closed exn:i/o:tcp exn:i/o:udp exn:misc exn:misc:application exn:misc:unsupported exn:module exn:read
    syn keyword schemeExtFunc exn:read:non-char exn:special-comment exn:syntax exn:thread exn:user exn:variable exn:application:mismatch
    syn keyword schemeExtFunc exn? exn:application:arity? exn:application:continuation? exn:application:fprintf:mismatch? exn:application:mismatch?
    syn keyword schemeExtFunc exn:application:type? exn:application:mismatch? exn:break? exn:i/o:filesystem? exn:i/o:port? exn:i/o:port:closed?
    syn keyword schemeExtFunc exn:i/o:tcp? exn:i/o:udp? exn:misc? exn:misc:application? exn:misc:unsupported? exn:module? exn:read? exn:read:non-char?
    syn keyword schemeExtFunc exn:special-comment? exn:syntax? exn:thread? exn:user? exn:variable? exn:application:mismatch?
    " Command-line parsing
    syn keyword schemeExtFunc command-line current-command-line-arguments once-any help-labels multi once-each 

    " syntax quoting, unquoting and quasiquotation
    syn region schemeUnquote matchgroup=Delimiter start="#," end=![ \t\[\]()";]!me=e-1 contains=ALL
    syn region schemeUnquote matchgroup=Delimiter start="#,@" end=![ \t\[\]()";]!me=e-1 contains=ALL
    syn region schemeUnquote matchgroup=Delimiter start="#,(" end=")" contains=ALL
    syn region schemeUnquote matchgroup=Delimiter start="#,@(" end=")" contains=ALL
    syn region schemeUnquote matchgroup=Delimiter start="#,\[" end="\]" contains=ALL
    syn region schemeUnquote matchgroup=Delimiter start="#,@\[" end="\]" contains=ALL
    syn region schemeQuoted matchgroup=Delimiter start="#['`]" end=![ \t()\[\]";]!me=e-1 contains=ALL
    syn region schemeQuoted matchgroup=Delimiter start="#['`](" matchgroup=Delimiter end=")" contains=ALL
endif


if exists("b:is_chicken") || exists("is_chicken")
    " multiline comment
    syntax region schemeMultilineComment start=/#|/ end=/|#/ contains=schemeMultilineComment

    syn match schemeOther "##[-a-z!$%&*/:<=>?^_~0-9+.@#%]\+"
    syn match schemeExtSyntax "#:[-a-z!$%&*/:<=>?^_~0-9+.@#%]\+"

    syn keyword schemeSyntax define-method

    syn keyword schemeExtSyntax module import require-library use
    syn keyword schemeExtSyntax define-class define-generic

    syn keyword schemeKeyword reader: writer: accessor: initform: metaclass:

    syn keyword schemeExtSyntax unit uses declare hide
    syn keyword schemeExtSyntax foreign-lambda foreign-lambda* define-external define-macro load-library
    syn keyword schemeExtSyntax let-values let*-values letrec-values ->string require-extension
    syn keyword schemeExtSyntax let-optionals let-optionals* define-foreign-variable define-record
    syn keyword schemeExtSyntax pointer tag-pointer tagged-pointer? define-foreign-type
    syn keyword schemeExtSyntax require require-for-syntax cond-expand and-let* receive argc+argv
    syn keyword schemeExtSyntax fixnum? fx= fx> fx< fx>= fx<= fxmin fxmax
    syn keyword schemeExtFunc ##core#inline ##sys#error ##sys#update-errno

    " here-string
    syn region schemeString start=+#<<\s*\z(.*\)+ end=+^\z1$+

    " suggested by Alex Queiroz
    " syn match schemeExtSyntax "#![-a-z!$%&*/:<=>?^_~0-9+.@#%]\+"
    " syn region schemeString start=+#<#\s*\z(.*\)+ end=+^\z1$+ 
 
    unlet! b:current_syntax
    syn include @ChickenC syntax/c.vim

    syn region ChickenC matchgroup=schemeOther start=+(\@<=foreign-declare "+ end=+")\@=+ contains=@ChickenC
    syn region ChickenC matchgroup=schemeComment start=+foreign-declare\s*#<<\z(.*\)$+hs=s+15 end=+^\z1$+ keepend contains=@ChickenC

    syn region ChickenC matchgroup=schemeOther start=+(\@<=foreign-parse "+ end=+")\@=+ contains=@ChickenC
    syn region ChickenC matchgroup=schemeComment start=+foreign-parse\s*#<<\z(.*\)$+hs=s+13 end=+^\z1$+ keepend contains=@ChickenC

    syn region ChickenC matchgroup=schemeOther start=+(\@<=foreign-parse/spec "+ end=+")\@=+ contains=@ChickenC
    syn region ChickenC matchgroup=schemeComment start=+foreign-parse/spec\s*#<<\z(.*\)$+hs=s+18 end=+^\z1$+ keepend contains=@ChickenC

    syn region ChickenC matchgroup=schemeComment start=+#>+ end=+<#+ contains=@ChickenC
    syn region ChickenC matchgroup=schemeComment start=+#>?+ end=+<#+ contains=@ChickenC
    syn region ChickenC matchgroup=schemeComment start=+#>!+ end=+<#+ contains=@ChickenC
    syn region ChickenC matchgroup=schemeComment start=+#>\$+ end=+<#+ contains=@ChickenC
    syn region ChickenC matchgroup=schemeComment start=+#>%+ end=+<#+ contains=@ChickenC
endif

if exists("b:is_gambit") || exists("is_gambit")
    syntax region schemeMultilineComment start=/#|/ end=/|#/ contains=schemeMultilineComment

    " UUID - used for identifiers in (define-type)
    syntax match schemeConstant /\x\{8\}-\x\{4\}-\x\{4\}-\x\{4\}-\x\{12\}/

    " DSSL-style lambda things
    syntax keyword schemeExtSyntax #!optional #!rest #!key #!eof #!void

    syntax keyword schemeSyntax namespace

    syntax keyword schemeExtSyntax define-macro define-structure define-type
    syntax keyword schemeExtSyntax c-define c-define-type c-lambda

    syntax keyword schemeFunc box box? unbox set-box!

    syntax region schemeSexpComment start='#;(' end=')' contains=schemeSexp,schemeComment

    syntax match schemeKeyword /[^. \t\[\]()";]\+:/
    syntax match schemeOther /##[^. \t\[\]()";]\+/

    unlet! b:current_syntax
    syntax include @GambitC syntax/c.vim
    syntax region GambitC matchgroup=schemeOther start=+(\@<=c-declare "+ end=+")\@=+ contains=@GambitC
    syntax region GambitC matchgroup=schemeComment start=+c-declare\s*#<<\z(.*\)$+hs=s+9 end=+^\z1$+ keepend contains=@GambitC

    syntax region GambitC matchgroup=schemeOther start=+(\@<=c-initialize "+ end=+")\@=+ contains=@GambitC
    syntax region GambitC matchgroup=schemeComment start=+c-initialize\s*#<<\z(.*\)$+hs=s+12 end=+^\z1$+ keepend contains=@GambitC
endif

if exists('b:is_gauche') || exists('is_gauche')
    syntax region schemeRegexp start=!#/! skip=!\\/! end=!/!
    syntax region schemeInterpString start=!#`"! skip=!\\"! end=!"! contains=schemeInterpStringValue
    syntax match schemeKeyword /:[^. \t\[\]()";]\+/
    syntax match schemeInterpStringValue !,[A-Za-z0-9\-]\+! contained
    syntax region schemeSexpComment start=!#;(! end=!)! contains=schemeSexp,schemeComment
endif

if exists('b:is_guile') || exists('is_guile')
    syntax keyword schemeExtSyntax define-class define-generic define-method define-module use-modules while
    syntax match schemeKeyword /#:[^ ]\+/
    syntax match schemeChar !#\\\(nul\|alarm\|backspace\|tab\|linefeed\|vtab\|page\|return\|esc\|delete\)!
    syntax keyword schemeExtSyntax catch
endif

if exists('b:is_mit') || exists('is_mit')
    syntax keyword schemeExtSyntax load-option
    syntax keyword schemeExtFunc ->pathname ->namestring
    syntax keyword schemeKeyword constructor print-procedure
endif

if exists('b:is_bigloo') || exists('is_bigloo')
    syntax keyword schemeExtSyntax module
    syntax keyword schemeExtSyntax #!optional #!rest #!key
    syntax match   schemeExplicitType /::[A-Za-z][\[\]A-Za-z0-9_.-]*/
endif

if exists('b:is_kawa') || exists('is_kawa')
    syntax keyword schemeExtSyntax make-parameter parameterize let-values let*-values
    syntax keyword schemeExtSyntax define-alias define-class define-simple-class define-record-type define-enum define-namespace
    syntax keyword schemeExtSyntax #!optional #!rest #!key #!eof #!void #!null #!abstract #!native
    syntax region  schemeComment start="#|" end="|#"
    syntax match   schemeExplicitType /::[A-Za-z][\[\]A-Za-z0-9_.-]*/
    syntax keyword schemeKeyword interface: access: class-name: type: allocation: init: init-form: init-value: init-keyword: throws:
endif

if exists('b:is_stklos') || exists('is_stklos')
    " The STklos module system syntax and procedures.
    syntax keyword schemeExtSyntax  define-module export import select-module in-module
    syntax keyword SchemeExtFunc  current-module find-module module? symbol-value symbol-value*
    syntax keyword SchemeExtFunc  module-name module-imports module-exports module-symbols all-modules

    syntax keyword schemeExtSyntax  define-class define-generic define-method
    syntax keyword schemeExtSyntax  match-case

    syntax keyword schemeExtSyntax #!optional #!rest #!key
    syntax match schemeKeyword /:[^. \t\[\]()";]\+/
endif

" Synchronization and the wrapping up...

syn sync match matchPlace grouphere NONE "^[^ \t]"
" ... i.e. synchronize on a line that starts at the left margin

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_scheme_syntax_inits")
  if version < 508
    let did_scheme_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink schemeSyntax   Statement
  HiLink schemeFunc   Function

  HiLink schemeString   String
  HiLink schemeChar   Character
  HiLink schemeNumber   Number
  HiLink schemeBoolean    Boolean

  HiLink schemeDelimiter  Delimiter
  HiLink schemeConstant   Constant

  HiLink schemeComment    Comment
  HiLink schemeSexpComment  Comment
  HiLink schemeMultilineComment Comment
  HiLink schemeError    Error

  HiLink schemeExplicitType     Type

  HiLink schemeExtSyntax  Type
  HiLink schemeExtFunc    PreProc

  HiLink schemeRegexp   String
  HiLink schemeInterpString String
  HiLink schemeInterpStringValue  Identifier

  HiLink schemeKeyword    Special

  delcommand HiLink
endif

let b:current_syntax = "scheme"

