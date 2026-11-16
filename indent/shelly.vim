" Vim indent file for Shelly blocks.
if exists("b:did_shelly_indent")
  finish
endif
let b:did_shelly_indent = 1

setlocal indentexpr=GetShellyIndent()
setlocal indentkeys=o,O,*<Return>,0=end

function! GetShellyIndent(...) abort
  let lnum = a:0 ? a:1 : v:lnum
  let previous = prevnonblank(l:lnum - 1)
  if previous == 0
    return 0
  endif

  let indent = indent(previous)
  let current_text = getline(l:lnum)
  let previous_text = getline(previous)

  if lnum > 1 && current_text =~ '^\s*end\>'
    return max([0, indent - shiftwidth()])
  endif
  if previous_text =~ '^\s*\(if\|elif\|else\|repeat\|while\|for\|fn\|try\|catch\|case\|when\|retry\|pipeline\|parallel\|table\|measure\)\>'
    return indent + shiftwidth()
  endif
  return indent
endfunction
