local M = {}

local warned_missing = false

local config = {
  cmd = { "shelly-lsp" },
  root_markers = { "Shelly.toml", ".git" },
}

local function project_root(bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr)
  local directory = vim.fn.fnamemodify(name, ":p:h")

  if config.root_dir then
    if type(config.root_dir) == "function" then
      return config.root_dir(bufnr, directory) or directory
    end
    return config.root_dir
  end

  -- Marker order is significant: prefer Shelly.toml anywhere above the file,
  -- then fall back to .git, rather than choosing a nearer lower-priority marker.
  for _, marker in ipairs(config.root_markers) do
    local candidate_directory = directory
    while candidate_directory and candidate_directory ~= "" do
      local candidate = candidate_directory .. "/" .. marker
      if vim.fn.filereadable(candidate) == 1 or vim.fn.isdirectory(candidate) == 1 then
        return candidate_directory
      end

      local parent = vim.fn.fnamemodify(candidate_directory, ":h")
      if parent == candidate_directory then
        break
      end
      candidate_directory = parent
    end
  end

  return vim.fn.fnamemodify(name, ":p:h")
end

function M.setup(options)
  options = options or {}
  if options.cmd ~= nil then
    config.cmd = options.cmd
  end
  if options.root_markers ~= nil then
    config.root_markers = options.root_markers
  end
  if options.root_dir ~= nil then
    config.root_dir = options.root_dir
  end
end

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

  local executable = type(config.cmd) == "table" and config.cmd[1] or nil
  if type(executable) ~= "string" or vim.fn.executable(executable) ~= 1 then
    warn_missing()
    return
  end
  if has_client(bufnr) then
    return
  end

  vim.lsp.start({
    name = "shelly-lsp",
    cmd = config.cmd,
    filetypes = { "shelly" },
    root_dir = project_root(bufnr),
  }, { bufnr = bufnr })
end

return M
