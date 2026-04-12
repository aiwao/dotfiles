local M = {}

function M.setup(client, bufnr)
  local opts = { silent = true, buffer = bufnr }
  vim.keymap.set("n", "<F5>", function ()
    if vim.bo.modified then
      vim.cmd("w")
    end
    vim.cmd("JdtCompile incremental")
  end, opts)
  vim.keymap.set("n", "<F6>", function ()
    local dap = require("dap")
    if dap.session() == nil then
      if vim.bo.modified then
        vim.cmd("w")
      end
      ---@diagnostic disable-next-line: param-type-mismatch
      client:request_sync("java/buildWorkspace", false, 5000, bufnr)
      dap.continue()
    else
      dap.continue()
    end
  end, opts)
end

return M
