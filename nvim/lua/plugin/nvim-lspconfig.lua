vim.pack.add {
  "https://github.com/neovim/nvim-lspconfig",
}

local server_list = {
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
  "pyright"
}

local config_list = {
  ["css-lsp"] = {},
  ["css-variables-language-server"] = {},
  ["cssmodules-language-server"] = {},
  ["dockerfile-language-server"] = {},
  ["eslint-lsp"] = {},
  ["gofumpt"] = {},
  ["golangci-lint"] = {},
  ["gopls"] = {},
  ["gotests"] = {},
  ["html-lsp"] = {},
  ["sqlls"] = {},
  ["svelte-language-server"] = {},
  ["tailwindcss-language-server"] = {},
  ["typescript-language-server"] = {},
  ["pyright"] = {},
}

for _, server in ipairs(server_list) do
  local config = config_list[server] or {}
  config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
  vim.lsp.config(server, config)
end
vim.lsp.enable(server_list)
