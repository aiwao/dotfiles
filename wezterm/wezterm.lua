local wezterm = require("wezterm")

local keys = require("keymaps")

local config = {
  color_scheme = "Catppuccin Mocha",
  font = wezterm.font({
    family = "JetBrains Mono",
    harfbuzz_features = { "calt=0", "liga=0", "clig=0" },
  }),
  font_size = 13.0,
  use_ime = true,
  keys = keys,
  send_composed_key_when_left_alt_is_pressed = true,
  send_composed_key_when_right_alt_is_pressed = true,
  native_macos_fullscreen_mode = false,
}

wezterm.on('gui-startup', function()
  local _, _, window = wezterm.mux.spawn_window({})
  window:gui_window():maximize()
end)

return config
