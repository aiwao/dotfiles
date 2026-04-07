vim.pack.add {
  "https://github.com/neovim/nvim-lspconfig",
}

for server, config in pairs(require("aiwao.lsp.config")) do
  config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
  vim.lsp.config(server, config)
  if (server == "efm") then
    vim.lsp.enable(server)
  end
end
