local wezterm = require("wezterm")

local keys = require("keymaps")

local config = {
  color_scheme = "Tokyo Night",
  font = wezterm.font({
    family = "JetBrains Mono",
    harfbuzz_features = { "calt=0", "liga=0", "clig=0" },
  }),
  font_size = 13.0,
  use_ime = true,
  keys = keys,
}

wezterm.on('gui-startup', function()
    local _, _, window = wezterm.mux.spawn_window({})
    window:gui_window():toggle_fullscreen()
end)

return config
