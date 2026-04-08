--Load plugins
vim.pack.add {
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/mrcjkb/rustaceanvim",
  "https://github.com/mfussenegger/nvim-jdtls",
  "https://github.com/tjdevries/vlog.nvim",
}
require("aiwao.plugin.blink-cmp")
require("aiwao.plugin.nvim-lspconfig")
require("aiwao.plugin.snacks")
require("aiwao.plugin.bufferline")
require("aiwao.plugin.nvim-treesitter")
require("aiwao.plugin.oil")
require("aiwao.plugin.catppuccin")
require("aiwao.plugin.lualine")
require("aiwao.plugin.noice")
require("aiwao.plugin.intent-blankline")
require("aiwao.plugin.comment")
require("aiwao.plugin.crates")
require("aiwao.plugin.fff")
--Load configs
require("aiwao.config.generals")
require("aiwao.config.codestyles")
require("aiwao.config.keymaps")
require("aiwao.config.dashboard")
require("aiwao.config.diagnostic")
