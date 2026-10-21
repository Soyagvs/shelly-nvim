vim.opt.rtp:prepend((vim.fn.getcwd()))

local bufnr = vim.api.nvim_create_buf(false, true)
vim.api.nvim_set_current_buf(bufnr)
vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {
  'http GET "https://example.test/GET" headers {"POST": "body"} timeout 10 maxBytes 100',
  'http POST body "PUT"',
  'http PUT PATCH DELETE HEAD OPTIONS',
  '# GET POST headers body timeout maxBytes #',
})
vim.bo.filetype = "shelly"
vim.cmd("syntax on")
vim.cmd("set syntax=shelly")

local function group(line, col)
  return vim.fn.synIDattr(vim.fn.synID(line, col, 1), "name")
end

assert(group(1, 1) == "shellyHttpCommand", "http should have its own syntax group")
for _, token in ipairs({ "GET", "headers", "timeout", "maxBytes" }) do
  local col = vim.fn.match(vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1], "\\V" .. token) + 1
  assert(group(1, col) == (token == "GET" and "shellyHttpMethod" or "shellyHttpOption"), token .. " should be highlighted")
end
for _, token in ipairs({ "POST", "PUT", "PATCH", "DELETE", "HEAD", "OPTIONS" }) do
  local line = token == "POST" and 2 or 3
  local text = vim.api.nvim_buf_get_lines(bufnr, line - 1, line, false)[1]
  local col = vim.fn.match(text, "\\V" .. token) + 1
  assert(group(line, col) == "shellyHttpMethod", token .. " should be highlighted")
end
assert(group(1, 25) == "shellyString", "quoted URLs should remain strings")
local quoted_value = vim.fn.match(vim.api.nvim_buf_get_lines(bufnr, 1, 2, false)[1], '"PUT"') + 2
assert(group(2, quoted_value) == "shellyString", "quoted option values should remain strings")
assert(group(4, 3) == "shellyComment", "comments should remain comments")
vim.cmd("qa!")
