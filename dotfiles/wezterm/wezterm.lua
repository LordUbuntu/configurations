local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- looks
--   change color scheme to match system automatically
function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'Gruvbox dark, medium (base16)'
  else
    return 'Gruvbox light, medium (base16)'
  end
end
wezterm.on('window-config-reloaded', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  local appearance = window:get_appearance()
  local scheme = scheme_for_appearance(appearance)
  if overrides.color_scheme ~= scheme then
    overrides.color_scheme = scheme
    window:set_config_overrides(overrides)
  end
end)
-- TODO: add a check for battery power to enable/disable cursor blinking
config.default_cursor_style = 'BlinkingUnderline'
config.cursor_blink_rate = 500
config.animation_fps = 144


-- font stuff (see: https://github.com/tonsky/FiraCode)
config.font = wezterm.font_with_fallback {
  {
    family = 'FiraCode Nerd Font Mono',
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
config.warn_about_missing_glyphs=false


-- warning: shrodinger's ime
config.use_ime = true


-- window
config.enable_tab_bar = false
config.window_close_confirmation = 'NeverPrompt'
config.enable_scroll_bar = true
config.window_padding = {
  left = '3px',
  right = '3px',
  top = '3px',
  bottom = '3px',
}
-- config.window_background_opacity = 0.96

-- render
-- config.dpi = 192.0  -- potential fix for high res monitors
config.max_fps = 144
config.enable_wayland = false

return config
