local ok, color_scheme = require("config.catppuccin")
if not ok then
  return
end


vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
vim.cmd [[
  syntax enable
  colorscheme catppuccin
]]
