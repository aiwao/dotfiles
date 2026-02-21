vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.cmd("terminal")
  end,
})
