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
    weight = 'Light',
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
      'ss09',
    },
  },
  {
    family = 'Noto Sans Mono',
    weight = 'Regular',
  },
  {
    family = 'Noto Sans CJK SC',
    weight = 'Regular',
  },
}
-- config.font = wezterm.font('Fira Code Nerd Font Mono')
config.font_size = 13

-- window
config.enable_tab_bar = false

-- ime
config.use_ime = true

return config
