local dap = require("dap")
dap.configurations.java = {
  {
    type = "java";
    request = "attach";
    name = "Debug (Attach) - Remote";
    hostName = "127.0.0.1";
    port = 5005;
  },
  -- Minecraft fabric dap setup:
  -- 1. Run `./gradlew vscode`
  -- 2. Run `:DapNew`
  --
  --
  -- If error occurred about OpenGL:
  -- 1. Write a wrapper script
  --
  -- ./java-nixgl:
  -- ```
  -- #!/home/aiwao/.nix-profile/bin/zsh
  -- exec nixGLIntel java "$@"
  -- ```
  --
  -- 2. Add a permission to the script
  -- `chmod +x ./java-nixgl`
  --
  -- 3. Edit a `./vscode/launch.json`
  -- Create a json entry `"javaExec": "./java-nixgl"`
}

local jdtls_bin_path = vim.fn.exepath("jdtls")
if (vim.lsp.is_enabled("jdtls") or (jdtls_bin_path == "")) then
  return
end

local jdtls = require("jdtls")
jdtls.jol_path = os.getenv("NEOVIM_JOL_JAR")

local config = vim.lsp.config["jdtls"]
local cmd = {
  os.getenv("JDK21") .. "/bin/java",
  -- '-agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=1044',
  "-Declipse.application=org.eclipse.jdt.ls.core.id1",
  "-Dosgi.bundles.defaultStartLevel=4",
  "-Declipse.product=org.eclipse.jdt.ls.core.product",
  "-Dlog.protocol=true",
  "-Dlog.level=ALL",
  "-XX:+UseTransparentHugePages",
  "-XX:+AlwaysPreTouch",
  "-Xmx3g",
  "-javaagent:" .. os.getenv("NEOVIM_LOMBOK_JAR"),
  "--add-modules=ALL-SYSTEM",
  "--add-opens", "java.base/java.util=ALL-UNNAMED",
  "--add-opens", "java.base/java.lang=ALL-UNNAMED",
}
config.cmd = cmd

local jdtls_path = vim.fn.fnamemodify(jdtls_bin_path, ":h:h") .. "/share/java/jdtls/"
local plugins_path = jdtls_path .. "plugins/"
local home = os.getenv("HOME")
local cache_path = home .. "/.cache/jdtls/"

local launcher_path = vim.fn.glob(plugins_path .. "org.eclipse.equinox.launcher_*.jar")
if vim.uv.fs_stat(launcher_path) then
  local src_config_path = vim.uv.os_uname().sysname:lower() == "linux" and "config_linux/" or "config_mac/"
  local config_path = cache_path .. src_config_path
  vim.fn.mkdir(config_path, "p")
  vim.uv.fs_copyfile(jdtls_path .. src_config_path .. "config.ini", config_path .. "config.ini")

  vim.list_extend(cmd, {
    "-jar", launcher_path,
    "-configuration", config_path,
  })
else
  vim.notify(launcher_path .. "is not found", vim.log.levels.ERROR)
  return
end

local root_dir = config.root_dir or vim.fs.root(0, config.root_markers)
local datadir
if type(root_dir) == "string" then
  datadir = cache_path .. "projects/" .. root_dir:gsub("/", "_") .. vim.fn.sha256(root_dir)
  vim.fn.mkdir(datadir, "p")
  table.insert(cmd, "-data")
  table.insert(cmd, datadir)
end

-- mute; having progress reports is enough
config.handlers = {
  ["language/status"] = function() end
}
jdtls.start_or_attach(config)
require("jdtls.dap").setup_dap { hotcodereplace = "auto" }
