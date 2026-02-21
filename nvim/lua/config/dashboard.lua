vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.cmd("terminal")
  end,
})
