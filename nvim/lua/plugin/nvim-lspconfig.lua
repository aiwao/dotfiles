vim.pack.add {
  "https://github.com/neovim/nvim-lspconfig",
}

local server_list = {}
local config_list = {
  ["efm"] = {},
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
  ["rust-analyzer"] = {
    settings = {
      ["rust-analyzer"] = {
        files = {
          excludeDirs = {
            ".direnv",
            ".git",
            "target",
            "result",
          },
        },
      },
    },
  }
}

for server, config in pairs(config_list) do
  config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
  vim.lsp.config(server, config)
  server_list[#server_list + 1] = server
end
vim.lsp.enable(server_list)
