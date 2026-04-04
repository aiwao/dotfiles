vim.pack.add { "https://github.com/catppuccin/nvim" }
require("catppuccin").setup {
  flavour = "mocha",
  custom_highlights = function(colors)
    return {
      LineNr = { fg = colors.flamingo, style = { "bold" } },
      CursorLineNr = { fg = colors.sappire, style = { "bold" } },
    }
  end
}
vim.cmd.colorscheme("catppuccin-nvim")
