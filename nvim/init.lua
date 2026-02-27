--Load plugins
vim.pack.add {
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/mrcjkb/rustaceanvim",
}
require("plugin.blink-cmp")
require("plugin.nvim-lspconfig")
require("plugin.snacks")
require("plugin.bufferline")
require("plugin.nvim-treesitter")
require("plugin.oil")
require("plugin.catppuccin")
require("plugin.lualine")
require("plugin.noice")
require("plugin.intent-blankline")
require("plugin.comment")
require("plugin.crates")
--Load configs
require("config.generals")
require("config.codestyles")
require("config.keymaps")
require("config.dashboard")
