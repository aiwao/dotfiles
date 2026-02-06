require("nvim-treesitter").setup()

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function(ctx)
    pcall(vim.treesitter.start)
  end,
})
