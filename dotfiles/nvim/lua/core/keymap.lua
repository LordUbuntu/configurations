-- helper function (functional wrapper for mapping keybinds)
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- define leader key as <space>
vim.g.mapleader = " "

----------
-- CORE
----------
-- navigation
map('n', 'j', 'gj')
map('n', 'k', 'gk')

-- window
map('n', '<leader>wh', '<C-w>h')
map('n', '<leader>wj', '<C-w>j')
map('n', '<leader>wk', '<C-w>k')
map('n', '<leader>wl', '<C-w>l')

-- buffer
map('n', '<leader>bn', '<cmd>bn<CR>')
map('n', '<leader>bp', '<cmd>bp<CR>')
map('n', '<leader>bk', '<cmd>bd<cr>')



------------
-- PLUGIN
------------

-- hop
-- can't seem to remove this right now without whichkey failing to detect it
vim.keymap.set('n', '<leader>ha', '<cmd>HopAnywhere<CR>')
vim.keymap.set('n', '<leader>hl', '<cmd>HopLine<CR>')
vim.keymap.set('n', '<leader>hw', '<cmd>HopWord<CR>')
vim.keymap.set('n', '<leader>hp', '<cmd>HopPattern<CR>')

-- telescope
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
