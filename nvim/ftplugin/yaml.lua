vim.lsp.enable("yamlls")

--docker-compose
local filename = vim.fn.expand("%:t:r")
if (filename == "docker-compose" or filename == "compose") then
  vim.lsp.enable("docker_compose_language_service")
end
