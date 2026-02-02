vim.o.autocomplete = true

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.o.signcolumn = 'yes:1'
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method('textDocument/completion') then
      vim.o.complete = 'o,.,w,b,u'
      vim.o.completeopt = 'menu,menuone,popup,noinsert,noselect'
      vim.lsp.completion.enable(true, client.id, args.buf)
    end
  end
})
