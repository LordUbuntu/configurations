local ok, papercolor = pcall(require, 'papercolor')
if not ok then
  return
end


-- load theme
vim.cmd [[
  set background=light
  colorscheme PaperColor
]]
