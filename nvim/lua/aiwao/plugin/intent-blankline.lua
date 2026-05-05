vim.pack.add { 
  "https://github.com/lukas-reineke/indent-blankline.nvim",
  "https://github.com/TheGLander/indent-rainbowline.nvim"
}
require("ibl").setup(require("indent-rainbowline").make_opts({
  indent = {
    smart_indent_cap = false,
  },
  scope = {
    show_start = false,
    show_end = false,
  },
}))
