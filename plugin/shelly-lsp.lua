if vim.g.loaded_shelly_lsp then
  return
end
vim.g.loaded_shelly_lsp = true

local function setup_icons()
  require("shelly-icons").setup()
end

setup_icons()
vim.schedule(setup_icons)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "shelly",
  callback = function(args)
    setup_icons()
    require("shelly.lsp").start(args.buf)
  end,
})
