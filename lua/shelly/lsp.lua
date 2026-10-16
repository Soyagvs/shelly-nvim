local M = {}

local warned_missing = false

local function warn_missing()
  if not warned_missing then
    warned_missing = true
    vim.notify(
      "Shelly LSP is not installed; install the shelly-lsp executable and ensure it is on PATH.",
      vim.log.levels.WARN
    )
  end
end

local function has_client(bufnr)
  if vim.lsp.get_clients then
    return #vim.lsp.get_clients({ bufnr = bufnr, name = "shelly-lsp" }) > 0
  end
  return #vim.lsp.get_active_clients({ bufnr = bufnr, name = "shelly-lsp" }) > 0
end

function M.start(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if not vim.api.nvim_buf_is_valid(bufnr)
    or vim.bo[bufnr].buftype ~= ""
    or vim.api.nvim_buf_get_name(bufnr) == ""
    or vim.bo[bufnr].filetype ~= "shelly" then
    return
  end

  if vim.fn.executable("shelly-lsp") ~= 1 then
    warn_missing()
    return
  end
  if has_client(bufnr) then
    return
  end

  vim.lsp.start({
    name = "shelly-lsp",
    cmd = { "shelly-lsp" },
    filetypes = { "shelly" },
    root_dir = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)),
  }, { bufnr = bufnr })
end

return M
