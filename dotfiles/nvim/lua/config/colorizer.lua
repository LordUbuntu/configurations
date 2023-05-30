-- colorizer plugin
-- see: https://github.com/norcalli/nvim-colorizer.lua
local ok, colorizer = pcall(require, "colorizer")
if not ok then
  return
end


colorizer.setup({
  '*';
  -- files can be specified specially, eg:
  -- css = {
  --   RGB      = true;  -- #RGB hex codes
  --   RRGGBB   = true;  -- #RRGGBB hex codes
  --   names    = true;  -- "Name" codes like Blue
  --   RRGGBBAA = true;  -- #RRGGBBAA hex codes
  --   rgb_fn   = true;  -- CSS rgb() and rgba() functions
  --   hsl_fn   = true;  -- CSS hsl() and hsla() functions
  --   css      = true;  -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
  --   css_fn   = true;  -- Enable all CSS *functions*: rgb_fn, hsl_fn
  --   -- Available modes: foreground, background
  --   mode     = 'background'; -- Set the display mode.
  -- }
}, { css = true; css_fn = true; })
