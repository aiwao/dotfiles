vim.pack.add {
  "https://github.com/neovim/nvim-lspconfig",
}

local config_list = {
  ["lua_ls"] = {},
  ["efm"] = {},
  ["csharp_ls"] = {},
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
  ["vala_ls"] = {},
  ["lemminx"] = {},
  ["kotlin_language_server"] = {},
}

for server, config in pairs(require("aiwao.lsp.config")) do
  config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
  vim.lsp.config(server, config)
  if (server == "efm") then
    vim.lsp.enable(server)
  end
end
