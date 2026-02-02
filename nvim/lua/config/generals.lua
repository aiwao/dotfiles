vim.g.mapleader = " "
vim.o.number = true
vim.o.relativenumber = true
vim.o.linebreak = true
vim.o.confirm = true
vim.o.termguicolors = true
vim.o.clipboard = "unnamedplus"

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank() end,
})
