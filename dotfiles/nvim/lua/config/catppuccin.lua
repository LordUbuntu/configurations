-- plugin: catppuccin  (color scheme)
-- url: https://github.com/catppuccin/nvim
local ok, catppuccin = pcall(require, 'catppuccin')
if not ok then
    return
end

catppuccin.setup({})
