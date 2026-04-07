vim.pack.add { "https://github.com/stevearc/oil.nvim" }
require("oil").setup {
  delete_to_trash = true,
  skip_confirm_for_simple_edits = true,
  default_file_explorer = true,
  view_options = {
    show_hidden = true,
  },
}
