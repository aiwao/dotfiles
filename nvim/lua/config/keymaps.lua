--Oil
local Oil = require("oil")
vim.keymap.set("n", "<leader>t", function() Oil.open_float() end, { silent = true })
vim.keymap.set("n", "<Esc>", function ()
  local winid = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_win_get_buf(winid)
  local is_oil = vim.bo[buf].filetype == "oil"
  local is_float = vim.api.nvim_win_get_config(winid).relative ~= ""
  if (is_oil and is_float) then
    Oil.close()
  end
end)

local fff = require("fff")
local Snacks = require("snacks")
--Find
vim.keymap.set("n", "<leader>ff",
  function()
    fff.scan_files()
    fff.refresh_git_status()
    fff.find_files()
  end
)
vim.keymap.set("n", "<leader>fg", function() fff.live_grep({ query = vim.fn.expand("<cword>") }) end)
vim.keymap.set("n", "<leader>fb", function() Snacks.picker.buffers() end)
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
