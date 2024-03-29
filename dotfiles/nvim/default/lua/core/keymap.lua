-- helper function (functional wrapper for mapping keybinds)
local map = require("core.helpers").map

-- define leader key as <space>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

----------
-- CORE --
----------
-- navigation
map('n', 'j', 'gj')
map('n', 'k', 'gk')
-- window
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- buffer
map('n', '<leader>bn', '<cmd>bnext<CR>', 'Next Buffer')
map('n', '<leader>bp', '<cmd>bprev<CR>', 'Previous Buffer')
map('n', '<leader>bd', '<cmd>bdel<cr>', 'Delete Buffer')

-- clear search highlight
map('n', '<leader>ul', '<cmd>nohlsearch<CR>', 'Clear Search Highlights')
