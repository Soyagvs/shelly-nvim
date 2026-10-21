vim.opt.rtp:prepend((vim.fn.getcwd()))

local started
vim.lsp.start = function(spec)
  started = spec
end
vim.lsp.get_clients = function()
  return {}
end

local lsp = require("shelly.lsp")
lsp.setup({ cmd = { "/bin/true", "--custom" } })

local bufnr = vim.api.nvim_create_buf(true, false)
vim.api.nvim_buf_set_name(bufnr, vim.fn.getcwd() .. "/custom.shelly")
vim.bo[bufnr].filetype = "shelly"
lsp.start(bufnr)

assert(started, "custom executable should start the LSP")
assert(started.cmd[1] == "/bin/true", "configured command should be passed to vim.lsp.start")
assert(started.cmd[2] == "--custom", "configured command arguments should be preserved")
vim.cmd("qa!")
