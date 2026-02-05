--Indent options
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

--Indent options by filetypes
local filetype_tabstop = {
  nix=2,
  lua=2,
  markdown=2,
  html=2,
  json=2,
  svelte=2,
  typescript=2,
  javascript=2,
  css=2,
}
--false=Use tab
local filetype_expand = {
  go=false,
}
--Set indent options for all languages
local usrftcfg = vim.api.nvim_create_augroup("UserFileTypeConfig", { clear = true})
vim.api.nvim_create_autocmd("FileType", {
  group = usrftcfg,
  callback = function (args)
    local fte = filetype_expand[args.match]
    if fte then
      vim.bo.expandtab = fte
    end

    local ftts = filetype_tabstop[args.match]
    if ftts then
      vim.bo.tabstop = ftts
      vim.bo.shiftwidth = ftts
    end
  end
})
