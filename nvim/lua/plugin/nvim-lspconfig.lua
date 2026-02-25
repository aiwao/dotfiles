vim.pack.add {
  "https://github.com/neovim/nvim-lspconfig",
}

local server_list = {}
local config_list = {
  ["efm"] = {},
  ["css_variables"] = {},
  ["cssmodules_ls"] = {},
  ["dockerls"] = {},
  ["docker_language_server"] = {},
  ["docker_compose_language_service"] = {},
  ["eslint"] = {},
  ["golangci_lint_ls"] = {},
  ["gopls"] = {},
  ["html"] = {},
  ["sqlls"] = {},
  ["svelte"] = {},
  ["tailwindcss"] = {},
  ["ts_ls"] = {},
  ["basedpyright"] = {},
  ["nixd"] = {},
  ["kotlin_language_server"] = {},
  ["jdtls"] = {},
  ["rust_analyzer"] = {
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
  vim.lsp.enable(server)
end
