--Replace leader
vim.g.mapleader = " "

--Set key maps
vim.keymap.set("n", "<leader>tt", "<cmd>NvimTreeToggle<CR>")

--Always show the line number
vim.o.number = true
--Show a relative number from current line 
vim.o.relativenumber = true

--Device clipboard
vim.o.clipboard = "unnamedplus"

--Indent options
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

--Indent options by filetypes
local filetype_tabstop = {
	lua=2,
	markdown=2,
	html=2,
}
--false=Use tab
local filetype_expand = {
	go=false,
}
--Set indent options for all languages
local usrftcfg = vim.api.nvim_create_augroup("UserFileTypeConfig", { clear = true})
vim.api.nvim_create_autocmd("FileType", {
  group = usrftcfg,
  callback = function (args)
		local fte = filetype_expand[args.match]
		if fte then
			vim.bo.expandtab = fte
		end

    local ftts = filetype_tabstop[args.match]
    if ftts then
      vim.bo.tabstop = ftts
      vim.bo.shiftwidth = ftts
    end
  end
})

--Lazy.nvim
require("config.lazy")

--Mason lsp
require("mason").setup()
require("mason-lspconfig").setup()

---Treesitter
require("nvim-treesitter").setup({
  install_dir = vim.fn.stdpath('data') .. '/site',
})
require("nvim-treesitter").install({ "go", })
vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function() vim.treesitter.start() end,
})

vim.diagnostic.config()
