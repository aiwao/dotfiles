---@type LSPModule
local M = {
  enable = function ()
    --rustaceanvim will enables rust-analyzer
  end
  config = {
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
}

return M
