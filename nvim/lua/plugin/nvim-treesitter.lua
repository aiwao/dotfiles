--nvim-treesitter was added by nix @nix/modules/home/programs/neovim.nix
require("nvim-treesitter").setup()

local treesittergroup = vim.api.nvim_create_augroup("TreesitterGroup", { clear = true})
vim.api.nvim_create_autocmd("FileType", {
  group = treesittergroup,
  pattern = "*",
  callback = function(ctx)
    pcall(vim.treesitter.start)
  end,
})
