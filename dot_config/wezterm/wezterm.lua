local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Macchiato'
config.window_decorations = "RESIZE"

local font_family = "Liga SFMono Nerd Font"


config.font = wezterm.font_with_fallback {
  { family = font_family }
}


local font_rules = {}
for _, italic in ipairs({ false, true }) do
  for intensity, weight in pairs({ Half = "Light", Normal = "Regular", Bold = "Bold" }) do
    font_rules[#font_rules + 1] = {
      italic = italic,
      intensity = intensity,
      font = wezterm.font_with_fallback {
        { family = font_family, italic = italic, weight = weight }
      }
    }
  end
end

config.font_rules = font_rules
config.font_size = 12.0

return config


