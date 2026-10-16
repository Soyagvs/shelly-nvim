vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.shelly",
  callback = function()
    vim.bo.filetype = "shelly"
  end,
})
