local ok, _ = require("config.catppuccin")
if not ok then
  return
end


-- setup theme
vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha

-- load theme
vim.cmd [[
  syntax enable
  colorscheme catppuccin
]]
