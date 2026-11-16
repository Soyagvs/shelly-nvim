vim.opt.rtp:prepend((vim.fn.getcwd()))

local bufnr = vim.api.nvim_create_buf(false, true)
vim.api.nvim_set_current_buf(bufnr)
vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {
  'retry 3',
  'pipeline build deploy',
  'parallel test lint',
  '"retry pipeline parallel"',
  '# retry pipeline parallel #',
  'menu "Choose a color"',
  '  keys numbers',
  '  keys letters lower',
  '  keys letters upper',
  '  option "Warm"',
  '  option[red] "Hot"',
  '  shellout ""',
  'clear',
  'progress "Syncing" -> $result',
  'choose "legacy"',
})
vim.bo.filetype = "shelly"
vim.cmd("syntax on")
vim.cmd("set syntax=shelly")

local function group(line, token)
  local text = vim.api.nvim_buf_get_lines(bufnr, line - 1, line, false)[1]
  local col = vim.fn.match(text, "\\V" .. token) + 1
  return vim.fn.synIDattr(vim.fn.synID(line, col, 1), "name")
end

for _, entry in ipairs({ { 1, "retry" }, { 2, "pipeline" }, { 3, "parallel" } }) do
  assert(group(entry[1], entry[2]) == "shellyKeyword", entry[2] .. " should be highlighted as a keyword")
end
assert(group(4, "retry") == "shellyString", "keywords in strings should remain strings")
assert(group(5, "retry") == "shellyComment", "keywords in comments should remain comments")
assert(group(6, "menu") == "shellyCommand", "menu should be highlighted as a command")
for _, entry in ipairs({
  { 7, "keys" },
  { 7, "numbers" },
  { 8, "keys" },
  { 8, "letters" },
  { 8, "lower" },
  { 9, "keys" },
  { 9, "letters" },
  { 9, "upper" },
  { 10, "option" },
  { 11, "option" },
}) do
  assert(group(entry[1], entry[2]) == "shellyMenuDirective", entry[2] .. " should be highlighted as a menu directive")
end
assert(group(10, '"Warm"') == "shellyString", "option label should remain a string")
assert(group(11, '"Hot"') == "shellyString", "explicit option label should remain a string")
assert(group(12, "shellout") == "shellyCommand", "blank-row shellout should be highlighted as a command")
assert(group(12, '""') == "shellyString", "blank-row shellout argument should remain a string")
assert(group(13, "clear") == "shellyCommand", "clear should be highlighted as a command")
assert(group(14, "progress") == "shellyCommand", "progress should be highlighted as a command")
assert(group(15, "choose") ~= "shellyCommand", "choose should no longer be highlighted as a command")

vim.api.nvim_buf_set_lines(bufnr, 15, -1, false, {
  'table ascii',
  '  column "Name"',
  '  row "Ada"',
  '  footer "Total"',
  '  border unicode',
  '  border rounded',
  '  column "table column row footer border ascii unicode rounded"',
  '  # table column row footer border ascii unicode rounded #',
  'end',
})
for _, entry in ipairs({
  { 16, "table" },
  { 17, "column" },
  { 18, "row" },
  { 19, "footer" },
  { 20, "border" },
}) do
  assert(group(entry[1], entry[2]) == "shellyKeyword", entry[2] .. " should be highlighted as a table keyword")
end
for _, entry in ipairs({ { 16, "ascii" }, { 20, "unicode" }, { 21, "rounded" } }) do
  assert(group(entry[1], entry[2]) == "shellyConstant", entry[2] .. " should be highlighted as a border value")
end
assert(group(22, "table") == "shellyString", "table words in strings should remain strings")
assert(group(23, "table") == "shellyComment", "table words in comments should remain comments")

vim.api.nvim_buf_set_lines(bufnr, 24, -1, false, {
  'measure -> $milliseconds',
  '  log "measure table end $milliseconds"',
  '  # measure table end $milliseconds #',
  '  table ascii',
  '    column "Elapsed"',
  '    row "$milliseconds"',
  '  end',
  'end',
})
assert(group(25, "measure") == "shellyKeyword", "measure should be highlighted as a keyword")
assert(group(25, "->") == "shellyOperator", "measure arrow should be highlighted as an operator")
assert(group(25, "$milliseconds") == "shellyVariable", "measure output should be highlighted as a variable")
assert(group(26, "measure") == "shellyString", "measure words in strings should remain strings")
assert(group(27, "measure") == "shellyComment", "measure words in comments should remain comments")
assert(group(28, "table") == "shellyKeyword", "table should remain a keyword inside measure")
assert(group(29, "column") == "shellyKeyword", "column should remain a table keyword inside measure")
assert(group(30, "row") == "shellyKeyword", "row should remain a table keyword inside measure")

vim.cmd("set shiftwidth=2")
vim.cmd("set runtimepath^=" .. vim.fn.getcwd())
vim.cmd("filetype indent on")
vim.bo.filetype = "shelly"
vim.cmd("runtime! indent/shelly.vim")
assert(vim.fn.GetShellyIndent(26) == 2, "measure body should indent")
assert(vim.fn.GetShellyIndent(29) == 4, "table body should nest inside measure")
assert(vim.fn.GetShellyIndent(31) == 2, "table end should dedent")
assert(vim.fn.GetShellyIndent(32) == 0, "measure end should dedent")
vim.cmd("qa!")
