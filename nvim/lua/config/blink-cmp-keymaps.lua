return {
  preset = "none",

  ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
  ["<C-e>"] = { "hide", "fallback" },
  ["<CR>"] = { "accept", "fallback" },

  ["<Tab>"] = { "select_next", "fallback" },
  ["<S-Tab>"] = { "select_prev", "fallback" },

  ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
  ["<C-n>"] = { "select_next", "fallback_to_mappings" },

  ["<C-b>"] = { "scroll_documentation_up", "fallback" },
  ["<C-f>"] = { "scroll_documentation_down", "fallback" },

  ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
}
