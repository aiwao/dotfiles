--Load configs
require("config.globals")
require("config.keymaps")
require("config.codestyles")
require("config.lazy")

--Mason lsp
require("mason").setup()
require("mason-lspconfig").setup()

--Lualine
require('lualine').setup()

--Bufferline
vim.opt.termguicolors = true
require("bufferline").setup()

vim.diagnostic.config()
