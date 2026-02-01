vim.pack.add { "https://github.com/neovim/nvim-lspconfig" }
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

vim.lsp.enable {
  "css-lsp",
  "css-variables-language-server",
  "cssmodules-language-server",
  "dockerfile-language-server",
  "eslint-lsp",
  "gofumpt",
  "golangci-lint",
  "gopls",
  "gotests",
  "html-lsp",
  "sqlls",
  "svelte-language-server",
  "tailwindcss-language-server",
  "typescript-language-server",
}
