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
  ["jdtls"] = {
    root_markers = {
      -- Multi-module projects
      "mvnw", -- Maven
      "gradlew", -- Gradle
      "settings.gradle", -- Gradle
      "settings.gradle.kts", -- Gradle
      -- Use git directory as last resort for multi-module maven projects
      -- In multi-module maven projects it is not really possible to determine what is the parent directory
      -- and what is submodule directory. And jdtls does not break if the parent directory is at higher level than
      -- actual parent pom.xml so propagating all the way to root git directory is fine
      ".git",

      -- Single-module projects
      "build.xml", -- Ant
      "pom.xml", -- Maven
      "build.gradle", -- Gradle
      "build.gradle.kts", -- Gradle
    },
    settings = {
      java = {
        autobuild = { enabled = false },
        maxConcurrentBuilds = 8,
        signatureHelp = { enabled = true };
        contentProvider = { preferred = 'fernflower' };
        saveActions = {
          organizeImports = true,
        },
        completion = {
          favoriteStaticMembers = {
            "io.crate.testing.Asserts.assertThat",
            "org.assertj.core.api.Assertions.assertThat",
            "org.assertj.core.api.Assertions.assertThatThrownBy",
            "org.assertj.core.api.Assertions.catchThrowable",
            "java.util.Objects.requireNonNull",
            "java.util.Objects.requireNonNullElse",
            "org.mockito.Mockito.mock",
            "org.mockito.Mockito.when",
          },
          filteredTypes = {
            "com.sun.*",
            "io.micrometer.shaded.*",
            "java.awt.*",
            "jdk.internal.*",
            "sun.*",
          },
        };
        sources = {
          organizeImports = {
            starThreshold = 9999;
            staticStarThreshold = 9999;
          };
        };
        codeGeneration = {
          toString = {
            template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
          },
          hashCodeEquals = {
            useJava7Objects = false,
            useInstanceOf = true,
          },
          useBlocks = true,
          addFinalForNewDeclaration = "fields",
        };
        import = {
          gradle = {
            enabled = true
          },
          maven = {
            enabled = true
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
  --nvim-jdtls enables jdtls manually
  if not (server == "rust_analyzer" or server == "jdtls") then
    vim.lsp.enable(server)
  end
end
