vim.pack.add {
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
}

require("mason").setup()
vim.lsp.enable {
  "css-lsp",
  "css-variables-language-server",
  "cssmodules-language-server",
  "dockerfile-language-server",
  "eslint-lsp",
  "gofumpt",
  "golangci-lint",
  "gopls",
  "gotests",
  "html-lsp",
  "sqlls",
  "svelte-language-server",
  "tailwindcss-language-server",
  "typescript-language-server",
}
