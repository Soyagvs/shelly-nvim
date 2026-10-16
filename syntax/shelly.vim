" Vim syntax file for Shelly `.shelly` scripts
if exists("b:current_syntax")
  finish
endif

syntax case match

" Comments use Shelly's paired hash form: # comment #
syntax region shellyComment start=/#/ end=/#/ contains=NONE

" Strings: ordinary quoted strings and triple-backtick multiline strings.
syntax region shellyString start=/"/ skip=/\\"/ end=/"/ contains=shellyInterpolation
syntax region shellyMultilineString start=/```/ end=/```/ contains=shellyInterpolation keepend

syntax match shellyInterpolation /\$\$[A-Z][A-Z0-9_]*/ contained
syntax match shellyInterpolation /\$[A-Za-z][A-Za-z0-9_]*\(\(\.[A-Za-z_][A-Za-z0-9_]*\)\|\(\[[^\]]*\]\)\)*/ contained

" Language structure.
syntax keyword shellyKeyword if elif else end repeat while for in fn global export import include exit
syntax keyword shellyKeyword break continue return try catch case when
syntax keyword shellyLogic and or not
syntax keyword shellyBoolean true false
syntax keyword shellySpecial first last contained

" Built-in commands and predicates.
syntax keyword shellyCommand shellout shellin ask command call choose log
syntax keyword shellyCommand create copy move rename remove read write append prepend files
syntax match shellyPredicate /\v<(exists|contains|hasArg)>/

" Standard helpers.
syntax keyword shellyHelper arg args
syntax keyword shellyHelper trim lower upper replace split startsWith endsWith
syntax keyword shellyHelper len join sort reverse unique keys values
syntax keyword shellyHelper toNumber toString isEmpty isNumber isText isList isDict
syntax keyword shellyHelper basename dirname extension withoutExtension
syntax keyword shellyHelper isFile isDir tempFile tempDir size
syntax keyword shellyHelper now today random randomInt jsonParse jsonStringify

" Identifiers and literals.
syntax match shellyFunction /\v<fn\s+\zs[A-Za-z_][A-Za-z0-9_]*/
syntax match shellyCall /\v<call\s+\zs[A-Za-z_][A-Za-z0-9_]*/
syntax match shellyVariable /\$[A-Za-z][A-Za-z0-9_]*\(\(\.[A-Za-z_][A-Za-z0-9_]*\)\|\(\[[^\]]*\]\)\)*/
syntax match shellyConstant /\$\$[A-Z][A-Z0-9_]*/
syntax match shellyNumber /\v<[-+]?[0-9]+(\.[0-9]+)?>/
syntax match shellyOperator /->\|==\|!=\|>=\|<=\|>\|<\|+\|-\|*\|\/\|=\|\.\./
syntax match shellyDelimiter /[{}()[\],:]/

" Keep selectors visible without swallowing nested expressions completely.
syntax match shellyListSelector /\[[^\]]*\]/ contains=shellyVariable,shellyConstant,shellyNumber,shellyString,shellyBoolean,shellyOperator,shellySpecial,shellyDelimiter

" Highlight dictionary keys in object literals and dotted paths.
syntax match shellyDictKey /\v<[A-Za-z_][A-Za-z0-9_-]*\ze\s*:/
syntax match shellyProperty /\v\.\zs[A-Za-z_][A-Za-z0-9_]*/

highlight default link shellyKeyword Keyword
highlight default link shellyLogic Operator
highlight default link shellyCommand Function
highlight default link shellyPredicate Function
highlight default link shellyHelper Function
highlight default link shellyFunction Function
highlight default link shellyCall Function
highlight default link shellyBoolean Boolean
highlight default link shellyVariable Identifier
highlight default link shellyConstant Constant
highlight default link shellyNumber Number
highlight default link shellyOperator Operator
highlight default link shellyDelimiter Delimiter
highlight default link shellyString String
highlight default link shellyMultilineString String
highlight default link shellyInterpolation Special
highlight default link shellyListSelector Special
highlight default link shellyDictKey Label
highlight default link shellyProperty Identifier
highlight default link shellySpecial Special
highlight default link shellyComment Comment

let b:current_syntax = "shelly"
