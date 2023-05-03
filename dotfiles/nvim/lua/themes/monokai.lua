local ok, monokai = pcall(require, 'monokai')
if not ok then
  return
end


-- setup theme
local palette = monokai.classic
monokai.setup({
  palette = palette,
  -- example hlgroups:
  custom_hlgroups = {
    GitSignsAdd = {
      fg = palette.green,
      bg = palette.base2,
    }
  }
})
