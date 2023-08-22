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
    family = 'Fira Code',
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
  -- fun fonts:
  -- - minecraft enchantment
  -- - CJK AllSeto
}
config.font_size = 13

-- warning: shrodinger's ime
config.use_ime = true

-- window
config.enable_tab_bar = false

return config

