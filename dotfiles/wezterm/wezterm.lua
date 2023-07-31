local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- colors
config.color_scheme = 'Gruvbox dark, medium (base16)'

-- font stuff (see: https://github.com/tonsky/FiraCode)
config.font = wezterm.font_with_fallback {
  {
    family = 'Fira Code Nerd Font Mono',
    weight = 'Medium',
    harfbuzz_features = {
      'zero',
      'calt',
      'clig',
      'cv01',
      'cv02',
      'cv04',
      'cv08',
      'cv21',
      'cv24',
      'cv25',
      'cv26',
      'cv30',
      'cv32',
      'ss07',
    },
  },
}
-- config.font = wezterm.font('Fira Code Nerd Font Mono')
--[[ config.harfbuzz_features = {
  'zero',
  'calt',
  'clig',
  'cv01',
  'cv02',
  'cv04',
  'cv08',
  'cv21',
  'cv24',
  'cv25',
  'cv26',
  'cv30',
  'cv32',
  'ss07',
} ]]
config.font_size = 13

return config
