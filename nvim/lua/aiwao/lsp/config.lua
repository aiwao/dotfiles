---@type LSPConfig
local configs = {}

---@type string[]
local module_list = {
  "css", "web", "rust"
}

for _, m in ipairs(module_list) do
  module_config = require("aiwao.lsp." .. m).config
  if module_config ~= nil then
    configs = vim.tbl_extend(configs, module_config)
  end
end

return configs
