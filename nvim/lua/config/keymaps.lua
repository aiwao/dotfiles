--Nvim tree
vim.keymap.set("n", "<leader>tt", "<cmd>NvimTreeToggle<CR>", { silent = true })
vim.keymap.set("n", "<leader>to", "<cmd>NvimTreeOpen<CR>", { silent = true })

--Bufferline
vim.keymap.set("n", "<leader>bn", "<cmd>BufferLineCycleNext<CR>", { silent = true })
vim.keymap.set("n", "<leader>bb", "<cmd>BufferLineCyclePrev<CR>", { silent = true })
vim.keymap.set("n", "<leader>bc", "<cmd>bdelete<CR>", { silent = true })

--Telescope
--vim.keymap.set("n", "<leader>ff", "<cmd>Telescope live_grep<CR>", { silent = true })

--Spectre
vim.keymap.set("n", "<leader>ff", '<cmd>lua require("spectre").toggle()<CR>')
vim.keymap.set("n", "<leader>fg", '<cmd>lua require("spectre").open_visual({ select_word = true })<CR>')

--Global
vim.keymap.set("n", "<leader>zz", vim.diagnostic.open_float)
