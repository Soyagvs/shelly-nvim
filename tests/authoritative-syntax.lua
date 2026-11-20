vim.opt.rtp:prepend((vim.fn.getcwd()))
local bufnr = vim.api.nvim_create_buf(false, true)
vim.api.nvim_set_current_buf(bufnr)
vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {
  'shellout $value',
  'http GET "url" headers {} timeout 1',
  'files "*.shelly" -> $files',
  'exists $path -> $found',
  'matches $value /a*b/',
  'trim $value -> $trimmed',
  'pathJoin $root $name -> $joined',
  'table border rounded',
  '  column "Name" align center',
  '  row "Ada"',
  '  footer "Total"',
  'menu "Pick"',
  '  keys letters lower',
  '  option "One"',
  '$lower = $UPPER',
  '"$lower $UPPER $$NAME $Mixed"',
  '# shellout $lower $$NAME #',
  '"literal star operator" $a * $b',
})
vim.bo.filetype = "shelly"
vim.cmd("syntax on")
vim.cmd("set syntax=shelly")
local function group(line, token)
  local text = vim.api.nvim_buf_get_lines(bufnr, line - 1, line, false)[1]
  local col = vim.fn.match(text, "\\V" .. token) + 1
  return vim.fn.synIDattr(vim.fn.synID(line, col, 1), "name")
end
assert(group(1, "shellout") == "shellyCommand")
assert(group(2, "http") == "shellyHttpCommand")
assert(group(2, "GET") == "shellyHttpMethod")
assert(group(3, "files") == "shellyCommand")
assert(group(4, "exists") == "shellyPredicate")
assert(group(5, "matches") == "shellyPredicate")
assert(group(6, "trim") == "shellyHelper")
assert(group(7, "pathJoin") == "shellyHelper")
assert(group(8, "table") == "shellyKeyword")
assert(group(9, "align") == "shellyKeyword")
assert(group(12, "menu") == "shellyCommand")
assert(group(13, "lower") == "shellyMenuDirective")
assert(group(15, "$lower") == "shellyVariable")
assert(group(15, "$UPPER") == "shellyConstant", group(15, "$UPPER"))
assert(group(16, "$$NAME") == "shellyInvalidIdentifier")
assert(group(16, "$Mixed") == "shellyInvalidIdentifier")
assert(group(17, "$$NAME") == "shellyComment")
assert(group(18, "*") == "shellyOperator")
assert(group(18, "literal") == "shellyString")
vim.cmd("qa!")
