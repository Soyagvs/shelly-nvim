vim.opt.rtp:prepend((vim.fn.getcwd()))

local bufnr = vim.api.nvim_create_buf(false, true)
vim.api.nvim_set_current_buf(bufnr)
vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {
  'mock http get "/status" returns {"ok": true}',
  'mock shellout returns "mocked"',
  'secret get API_TOKEN returns "value"',
  '"mock get returns secret http shellout" $value',
  '# mock get returns secret http shellout #',
})
vim.bo.filetype = "shelly"
vim.cmd("syntax on")
vim.cmd("set syntax=shelly")

local function group(line, token)
  local text = vim.api.nvim_buf_get_lines(bufnr, line - 1, line, false)[1]
  local col = vim.fn.match(text, "\\V" .. token) + 1
  return vim.fn.synIDattr(vim.fn.synID(line, col, 1), "name")
end

assert(group(1, "mock") == "shellyMockCommand", "mock should be highlighted")
assert(group(3, "secret") == "shellySecretCommand", "secret should be highlighted")
for _, token in ipairs({ "get", "returns" }) do
  assert(group(1, token) == "shellyMockSubcommand", token .. " should be highlighted")
end
for _, token in ipairs({ "http", "shellout" }) do
  local line = token == "http" and 1 or 2
  assert(group(line, token) == "shellyMockTarget", token .. " should be highlighted")
end
assert(group(1, '"/status"') == "shellyString", "strings should remain strings")
assert(group(4, "mock") == "shellyString", "strings should remain strings")
assert(group(4, "$value") == "shellyVariable", "variables should remain variables")
assert(group(5, "mock") == "shellyComment", "comments should remain comments")
vim.cmd("qa!")
