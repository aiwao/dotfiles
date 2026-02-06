local treesitter_grammars = vim.env.TREESITTER_GRAMMARS
if treesitter_grammars then
	vim.opt.runtimepath:append(treesitter_grammars)
end

vim.pack.add { "https://github.com/nvim-treesitter/nvim-treesitter" }
require("nvim-treesitter").setup()

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function(ctx)
    pcall(vim.treesitter.start)
  end,
})
