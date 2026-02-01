vim.pack.add { "https://github.com/nvim-treesitter/nvim-treesitter" }
local languages = {
  "go",
  "dockerfile",
  "dart",
  "ecma",
  "sql",
  "rust",
  "typescript",
  "javascript",
  "html",
  "html_tags",
  "css",
  "svelte",
  "tsx",
  "jsx",
}

require("nvim-treesitter.config").setup{
  ensure_installed = languages,
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = languages,
  callback = function()
    vim.treesitter.start()
  end,
})
