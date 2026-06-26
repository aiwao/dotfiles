---@type LSPModule
local M = {
  config = {
    efm = {
      cmd = { "efm-langserver" },
      filetypes = {
        "lua",
        "python",
        "go",
        "html",
        "svelte",
        "vue",
        "astro",
        "javascriptreact",
        "javascript.jsx",
        "typescriptreact",
        "typescript.tsx",
        "markdown",
        "markdown.mdx",
        "css",
        "scss",
        "less",
        "javascript",
        "typescript",
        "graphql",
        "handlebars",
        "swift",
        "json",
        "jsonc",
        "json5",
        "yaml",
        "dockerfile",
      },
      root_markers = {
        ".git",
        "package.json",
      },
      init_options = {
        documentFormatting = true,
        documentRangeFormatting = true,
        hover = true,
        documentSymbol = true,
        codeAction = true,
        completion = true,
      },
    },
  },
}

return M
