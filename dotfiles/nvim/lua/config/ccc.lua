-- Create Color Code in neovim plugin. Color picker and highlighter.
-- see: https://github.com/uga-rosa/ccc.nvim
local ok, ccc = pcall(require, "ccc")
if not ok then
  return
end


local mapping = ccc.mapping
ccc.setup({
  highlighter = {
    auto_enable = true,
    lsp = true,
  },
  inputs = {
    ccc.input.rgb,
    ccc.input.hsl,
    ccc.input.hsv,
    ccc.input.cmyk
  },
  outputs = {
    ccc.output.hex,
    ccc.output.hex_short,
    ccc.output.css_rgb,
    ccc.output.css_hsl,
  },
})
