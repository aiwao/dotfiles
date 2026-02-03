vim.pack.add { 
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/saghen/blink.cmp",
}
require("blink.cmp").setup {
  completion = { documentation = { auto_show = true } },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" }
}
