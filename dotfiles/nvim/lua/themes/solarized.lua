local ok, solarized = pcall(require, 'solarized')
if not ok then
  return
end


-- setup theme
vim.g.solarized_italic_comments = true
vim.g.solarized_italic_keywords = true
vim.g.solarized_italic_functions = true
vim.g.solarized_italic_variables = false
vim.g.solarized_contrast = true
vim.g.solarized_borders = false
vim.g.solarized_disable_background = false

-- load theme
solarized.set()
