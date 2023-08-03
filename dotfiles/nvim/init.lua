-- enable caching
vim.loader.enable()


-- load options
require("core.option")


-- load keymaps
require("core.keymap")


-- WARNING: leader key must be mapped before lazy.setup is called
require("core.lazy")


-- set colorscheme
vim.cmd[[
  autocmd ColorSchemePre gruvbox highlight link RainbowDelimiterRed GruvboxRed
  autocmd ColorSchemePre gruvbox highlight link RainbowDelimiterOrange GruvboxOrange
  autocmd ColorSchemePre gruvbox highlight link RainbowDelimiterYellow GruvboxYellow
  autocmd ColorSchemePre gruvbox highlight link RainbowDelimiterGreen GruvboxGreen
  autocmd ColorSchemePre gruvbox highlight link RainbowDelimiterCyan GruvboxAqua
  autocmd ColorSchemePre gruvbox highlight link RainbowDelimiterBlue GruvboxBlue
  autocmd ColorSchemePre gruvbox highlight link RainbowDelimiterViolet GruvboxPurple
]]
vim.cmd.colorscheme(require("core.helpers").try_colorscheme("gruvbox"))
