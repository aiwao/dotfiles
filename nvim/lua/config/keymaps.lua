--Nvim tree
vim.keymap.set("n", "<leader>tt", "<cmd>NvimTreeToggle<CR>", { silent = true })
vim.keymap.set("n", "<leader>to", "<cmd>NvimTreeOpen<CR>", { silent = true })

--Bufferline
vim.keymap.set("n", "<leader>bn", "<cmd>BufferLineCycleNext<CR>", { silent = true })
vim.keymap.set("n", "<leader>bb", "<cmd>BufferLineCyclePrev<CR>", { silent = true })
vim.keymap.set("n", "<leader>bc", "<cmd>bdelete<CR>", { silent = true })

--Telescope
--vim.keymap.set("n", "<leader>ff", "<cmd>Telescope live_grep<CR>", { silent = true })

--Global
vim.keymap.set("n", "<leader>zz", vim.diagnostic.open_float)
