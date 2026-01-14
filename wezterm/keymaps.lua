local wezterm = require("wezterm")
local act = wezterm.action

local keys = {
  { key = "t", mods = "ALT", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "y", mods = "ALT", action = act.CloseCurrentPane({ confirm = true }) }
}

-- activate tab
for i = 1, 9 do
	table.insert(keys, {
		key = tostring(i),
		mods = "ALT",
		action = act.ActivateTab(i - 1),
	})
end

return keys
