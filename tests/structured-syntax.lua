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
  '  subtitle "Colors" theme dark default red option red hint "Warm"',
  '  option blue hint "Cool"',
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
for _, directive in ipairs({ "subtitle", "theme", "default", "option", "hint" }) do
  assert(group(7, directive) == "shellyMenuDirective", directive .. " should be highlighted as a menu directive")
end
assert(group(8, "option") == "shellyMenuDirective", "option should be highlighted as a menu directive")
assert(group(9, "choose") ~= "shellyCommand", "choose should no longer be highlighted as a command")
vim.cmd("qa!")
