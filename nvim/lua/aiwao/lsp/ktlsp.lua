---@type LSPModule
local M = {
  enable = function ()
    vim.lsp.enable("ktlsp")
  end,
  config = {
    ktlsp = {
      cmd = { "ktlsp" },
      root_dir = vim.fs.root(0, {
        "settings.gradle.kts",
        "settings.gradle",
        "build.gradle.kts",
        "build.gradle",
        ".git",
      }),
    }
  }
}

return M
