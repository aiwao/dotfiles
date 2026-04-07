---@type LSPModule
local M = {}

function M.enable()
  vim.lsp.enable("eslint")
  vim.lsp.enable("ts_ls")
  vim.lsp.enable("html")
  require("lsp.css").enable()
end

return M
