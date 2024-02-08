local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Dracula (Official)'
config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE"
config.font = wezterm.font("Liga SFMono Nerd Font")

return config
