vim.opt.rtp:prepend((vim.fn.getcwd()))

local bufnr = vim.api.nvim_create_buf(false, true)
vim.api.nvim_set_current_buf(bufnr)
vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {
  'archive create from $source into "out.tar"',
  'archive extract from input into destination',
  'archive checksum check',
  '"archive create from into" $archive',
  '# archive create extract checksum check from into #',
})
vim.bo.filetype = "shelly"
vim.cmd("syntax on")
vim.cmd("set syntax=shelly")

local function group(line, token)
  local text = vim.api.nvim_buf_get_lines(bufnr, line - 1, line, false)[1]
  local col = vim.fn.match(text, "\\V" .. token) + 1
  return vim.fn.synIDattr(vim.fn.synID(line, col, 1), "name")
end

assert(group(1, "archive") == "shellyArchiveCommand", "archive should be highlighted")
for _, token in ipairs({ "create", "extract", "checksum", "check" }) do
  local line = token == "create" and 1 or token == "extract" and 2 or 3
  assert(group(line, token) == "shellyArchiveSubcommand", token .. " should be highlighted")
end
for _, token in ipairs({ "from", "into" }) do
  assert(group(1, token) == "shellyArchiveOption", token .. " should be highlighted")
end
assert(group(1, "$source") == "shellyVariable", "variables should remain variables")
assert(group(1, '"out.tar"') == "shellyString", "strings should remain strings")
assert(group(4, "archive") == "shellyString", "strings should remain strings")
assert(group(4, "$archive") == "shellyVariable", "variables should remain variables")
assert(group(5, "archive") == "shellyComment", "comments should remain comments")
vim.cmd("qa!")
