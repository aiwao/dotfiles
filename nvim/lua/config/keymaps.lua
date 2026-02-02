vim.keymap.set("n", "<leader>tt", "<cmd>Oil<CR>", { silent = true })

--Snacks
local Snacks = require("snacks")
--Find
vim.keymap.set("n", "<leader>fb", function() Snacks.picker.buffers() end)
vim.keymap.set("n", "<leader>ff", function() Snacks.picker.files() end)
--LSP
vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end)
vim.keymap.set("n", "gD", function() Snacks.picker.lsp_declarations() end)
--Buffer
vim.keymap.set("n", "<leader>bd", function() Snacks.bufdelete() end)
vim.keymap.set("n", "<leader>bn", "<cmd>BufferLineCycleNext<CR>", { silent = true })
vim.keymap.set("n", "<leader>bb", "<cmd>BufferLineCyclePrev<CR>", { silent = true })
--Diagnostic
vim.keymap.set("n", "<leader>zz", vim.diagnostic.open_float)
--Completion
vim.keymap.set("i", "<Tab>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-n>"
  end
  return "<Tab>"
end, { expr = true, noremap = true })
vim.keymap.set("i", "<S-Tab>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-p>"
  end
  return "<S-Tab>"
end, { expr = true, noremap = true })
-- vim.keymap.set("i", "<CR>", function()
--   if vim.fn.pumvisible() == 1 then
--     return "<C-y>"
--   end
--   return "<CR>"
-- end, { expr = true, noremap = true })
