vim.pack.add { 
  "https://github.com/rafamadriz/friendly-snippets",
  { src = "https://github.com/saghen/blink.cmp", version = "v1.8.0" },
}
require("blink.cmp").setup {
  completion = {
    documentation = { auto_show = true },
    list = {
      selection = {
        preselect = false,
      },
    },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
  keymap = require("config.blink-cmp-keymaps"),
}
