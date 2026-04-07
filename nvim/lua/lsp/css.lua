local M = {}

function M.enable()
  vim.lsp.enable("css_variables")
  vim.lsp.enable("cssmodules_ls")
  vim.lsp.enable("tailwindcss")
end

return M
