vim.pack.add { "https://github.com/mrcjkb/rustaceanvim" }
vim.g.rustaceanvim = {
  server = {
    default_settings = {
      -- rust-analyzer language server configuration
      require("aiwao.lsp.rust").config
    },
  },
}
