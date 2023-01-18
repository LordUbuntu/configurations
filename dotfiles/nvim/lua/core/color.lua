local ok, _ = pcall(require, "config.gruvbox-flat")
if not ok then
  return
end

vim.cmd [[
  syntax enable
  colorscheme gruvbox-flat
]]





--[[
local ok, _ = require("config.catppuccin")
if not ok then
  return
end

vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
vim.cmd [[
  syntax enable
  colorscheme catppuccin
]]

