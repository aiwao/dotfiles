---@type LSPModule
local M = {
  enable = function ()
    --nvim-jdtls will enables jdtls
  end,
  config = {
    ["jdtls"] = {
      before_init = function (params)
        ---@diagnostic disable-next-line: inject-field
        params.initializationOptions.bundles = { os.getenv("NEOVIM_JAVA_DEBUG") }
      end,
      on_attach = function (client, bufnr)
        require("aiwao.config.nvim-jdtls-keymaps").setup(client, bufnr)
      end,
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
    }
  }
}

return M
