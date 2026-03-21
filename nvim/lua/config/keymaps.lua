--Oil
local Oil = require("oil")
vim.keymap.set("n", "<leader>tt", function() Oil.open_float() end, { silent = true })

local Snacks = require("snacks")

--Find
vim.keymap.set("n", "<leader>fb", function() Snacks.picker.buffers() end)
vim.keymap.set("n", "<leader>ff", function() Snacks.picker.files() end)
vim.keymap.set("n", "<leader>fg", function() Snacks.picker.grep() end)

--LSP
vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end)
vim.keymap.set("n", "gD", function() Snacks.picker.lsp_declarations() end)

--Buffer
vim.keymap.set("n", "<leader>bd", function() Snacks.bufdelete() end)
vim.keymap.set("n", "<leader>bn", "<cmd>BufferLineCycleNext<CR>", { silent = true })
vim.keymap.set("n", "<leader>bb", "<cmd>BufferLineCyclePrev<CR>", { silent = true })
vim.keymap.set("n", "<leader>bm", "<cmd>BufferLinePick<CR>", { silent = true })

--Diagnostic
vim.keymap.set("n", "<leader>zz", vim.diagnostic.open_float)

--Terminal
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })
vim.keymap.set("t", "<C-Esc>", "<Esc>", { noremap = true }) --Mode escape in Neovim within the Neovim terminal

--Edit
vim.keymap.set("n", "U", "<C-r>", { noremap = true, silent = true })

--Disable
vim.keymap.set({ "n", "i", "v", "x", "o"}, "<PageUp>", "<Nop>", { silent = true })
vim.keymap.set({ "n", "i", "v", "x", "o"}, "<PageDown>", "<Nop>", { silent = true })
