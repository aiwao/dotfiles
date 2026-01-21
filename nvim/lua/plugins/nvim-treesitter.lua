return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  event = { "BufReadPost", "VeryLazy" },
  build = ":TSUpdate",
  main = "nvim-treesitter.config",
  config = function()
    local languages = {
        "go",
        "dockerfile",
        "dart",
        "ecma",
        "sql",
        "rust",
        "typescript",
        "javascript",
        "html",
        "html_tags",
        "css",
        "svelte",
        "tsx",
        "jsx",
    }

    require("nvim-treesitter.config").setup({
      ensure_installed = languages,
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
    
    vim.api.nvim_create_autocmd('FileType', {
      pattern = languages,
      callback = function()
        -- syntax highlighting, provided by Neovim
        vim.treesitter.start()
      end,
    })
  end,
}
