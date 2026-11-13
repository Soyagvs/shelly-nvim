if vim.g.loaded_shelly_lsp then
  return
end
vim.g.loaded_shelly_lsp = true

vim.api.nvim_create_autocmd("FileType", {
  pattern = "shelly",
  callback = function(args)
    -- Register Shelly's default purple icon when an optional provider is available.
    require("shelly-icons").setup()
    require("shelly.lsp").start(args.buf)
  end,
})
