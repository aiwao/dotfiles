---@type LSPConfig
local configs = {}

---@type string[]
local module_list = {
  "efm", "css", "web", "rust", "java"
}

for _, m in ipairs(module_list) do
  local module_config = require("aiwao.lsp." .. m).config
  if module_config ~= nil then
    configs = vim.tbl_extend("force", configs, module_config)
  end
end

return configs
