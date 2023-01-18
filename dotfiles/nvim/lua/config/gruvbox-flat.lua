-- plugin: gruvbox-flat  (color scheme)
-- url: https://github.com/eddyekofo94/gruvbox-flat.nvim
local ok, gruvbox = pcall(require, 'gruvbox-flat')
if not ok then
    return
end

gruvbox.setup({})
