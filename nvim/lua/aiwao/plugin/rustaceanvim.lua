vim.pack.add { "https://github.com/mrcjkb/rustaceanvim" }

vim.g.rustaceanvim = {
  server = {
    default_settings = require("aiwao.lsp.rust").config or {},
  },
}
