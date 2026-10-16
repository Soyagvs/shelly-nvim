local M = {}

local defaults = {
  -- Terminal Neovim file explorers usually render font glyphs, not SVG images.
  -- Pick a simple Nerd Font glyph and Shelly black.
  icon = "󱗆",
  color = "#000000",
  cterm_color = "16",
  name = "Shelly",
}

function M.setup_web_devicons(opts)
  local ok, devicons = pcall(require, "nvim-web-devicons")
  if not ok then
    return false, "nvim-web-devicons is not installed"
  end

  local icon = vim.tbl_extend("force", defaults, opts or {})
  devicons.setup({
    override_by_extension = {
      shelly = icon,
    },
  })
  return true
end

function M.setup_mini_icons(opts)
  local ok, mini_icons = pcall(require, "mini.icons")
  if not ok then
    return false, "mini.icons is not installed"
  end

  local icon = vim.tbl_extend("force", defaults, opts or {})
  mini_icons.setup({
    extension = {
      shelly = { glyph = icon.icon, hl = "ShellyIcon" },
    },
  })
  vim.api.nvim_set_hl(0, "ShellyIcon", { fg = icon.color })
  return true
end

function M.setup(opts)
  opts = opts or {}
  local did_setup = false

  if opts.web_devicons ~= false then
    local ok = M.setup_web_devicons(opts.icon)
    did_setup = did_setup or ok
  end

  if opts.mini_icons then
    local ok = M.setup_mini_icons(opts.icon)
    did_setup = did_setup or ok
  end

  return did_setup
end

return M
