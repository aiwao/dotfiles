vim.pack.add { "https://github.com/stevearc/oil.nvim" }
require("oil").setup {
  keymaps = { ['<C-h>'] = false },
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
}
