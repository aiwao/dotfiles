vim.keymap.set("n", "<leader>tt", ":Oil<CR>", { silent = true })

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
