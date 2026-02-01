vim.pack.add { "https://github.com/nvim-treesitter/nvim-treesitter" }
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

require("nvim-treesitter.config").setup{
  ensure_installed = languages,
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = languages,
  callback = function()
    vim.treesitter.start()
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.o.signcolumn = 'yes:1'
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method('textDocument/completion') then
      vim.o.complete = 'o,.,w,b,u'
      vim.o.completeopt = 'menu,menuone,popup,noinsert'
      vim.lsp.completion.enable(true, client.id, args.buf)
    end
  end
})

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank() end,
})
