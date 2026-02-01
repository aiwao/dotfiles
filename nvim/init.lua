--Load plugins
vim.pack.add { 
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/neovim/nvim-lspconfig",
}
require("plugin.snacks")
require("plugin.bufferline")
require("plugin.nvim-treesitter")
require("plugin.oil")
require("plugin.catppuccin")
require("plugin.lualine")

--Load configs
require("config.generals")
require("config.codestyles")
require("config.keymaps")
