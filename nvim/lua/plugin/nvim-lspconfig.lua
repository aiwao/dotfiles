vim.pack.add {
  "https://github.com/neovim/nvim-lspconfig",
}

local config_list = {
  ["lua_ls"] = {},
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
  ["vala_ls"] = {},
  ["lemminx"] = {},
  ["kotlin_language_server"] = {},
  ["jdtls"] = {
    settings = {
      java = {
        import = {
          gradle = {
            enable = true
          },
          maven = {
            enable = true
          },
        },
      },
    },
  },
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
        cargo = {
          buildScripts = {
            enable = true,
          },
        },
        procMacro = {
          enable = true,
        },
      },
    },
  }
}

for server, config in pairs(config_list) do
  config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
  vim.lsp.config(server, config)
  --rustaceanvim enables rust-analyzer manually
  if not (server == "rust_analyzer") then
    vim.lsp.enable(server)
  end
end
