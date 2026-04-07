---@type LSPModule
local M = {
  enable = function()
    vim.lsp.enable("eslint")
    vim.lsp.enable("ts_ls")
    vim.lsp.enable("html")
    require("aiwao.lsp.css").enable()
  end,
}

return M
