--Oil
local Oil = require("oil")
vim.keymap.set("n", "<leader>tt", function() Oil.open_float() end, { silent = true })

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
--Terminal
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })
