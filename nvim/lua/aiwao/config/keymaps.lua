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
vim.keymap.set({ "n", "v" }, "<leader>ff",
  function()
    fff.scan_files()
    fff.refresh_git_status()
    fff.find_files()
  end
)
vim.keymap.set({ "n", "v" }, "<leader>fg",
  function()
    local current_selected = ""
    local mode = vim.api.nvim_get_mode().mode
    if vim.tbl_contains({ "v", "V", "\22" }, mode) then
      local start_pos = vim.fn.getpos("v")
      local end_pos = vim.fn.getpos(".")
      local region = vim.fn.getregion(start_pos, end_pos, { type = mode })
      current_selected = table.concat(region, "\n")
    end
    fff.live_grep({ query = current_selected })
  end
)
vim.keymap.set({ "n", "v" }, "<leader>fb", function() Snacks.picker.buffers() end)
--LSP
vim.keymap.set("n", "<leader>gd", function() Snacks.picker.lsp_definitions() end)
vim.keymap.set("n", "<leader>gD", function() Snacks.picker.lsp_declarations() end)
vim.keymap.set("n", "<leader>gr", function() Snacks.picker.lsp_references() end)
vim.keymap.set("n", "<leader>gI", function() Snacks.picker.lsp_implementations() end)
vim.keymap.set("n", "<leader>gy", function() Snacks.picker.lsp_type_definitions() end)
vim.keymap.set("n", "<leader>inc", function() Snacks.picker.lsp_incoming_calls() end)
vim.keymap.set("n", "<leader>oug", function() Snacks.picker.lsp_outgoing_calls() end)
vim.keymap.set("n", "<leader>sym", function() Snacks.picker.lsp_symbols() end)
vim.keymap.set("n", "<leader>SYM", function() Snacks.picker.lsp_workspace_symbols() end)

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
--zsh does not approve "o", "O"
local function to_i_if_terminal(key)
  return vim.bo.buftype == "terminal" and "i" or key
end
vim.keymap.set("n", "o", function() return to_i_if_terminal("o") end, { expr = true, noremap = true })
vim.keymap.set("n", "O", function() return to_i_if_terminal("O") end, { expr = true, noremap = true })

--Edit
vim.keymap.set("n", "U", "<C-r>", { noremap = true, silent = true })

--Disable
vim.keymap.set({ "n", "i", "v", "x", "o"}, "<PageUp>", "<Nop>", { silent = true })
vim.keymap.set({ "n", "i", "v", "x", "o"}, "<PageDown>", "<Nop>", { silent = true })
