vim.api.nvim_create_autocmd("VimEnter", {
  callback = function(args)
    if vim.api.nvim_buf_get_name(args.buf) == "" then
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.cmd("terminal")
    end
  end,
})
