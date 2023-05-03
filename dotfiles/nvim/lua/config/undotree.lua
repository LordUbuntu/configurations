local ok, undotree = pcall(require, 'undotree')
if not ok then
  return
end


-- setup plugin
undotree.setup({
  float_diff = true,  -- using float window previews diff, set this `true` will disable layout option
  layout = "left_bottom", -- "left_bottom", "left_left_bottom"
  ignore_filetype = { 'Undotree', 'UndotreeDiff', 'qf', 'TelescopePrompt', 'spectre_panel', 'tsplayground' },
  window = {
    winblend = 30,
  },
  keymaps = {
    ['j'] = "move_next",        -- jump to next undo node
    ['k'] = "move_prev",        -- jump to prev undo node
    ['J'] = "move_change_next", -- jump to next undo node, undo to that state
    ['K'] = "move_change_prev", -- jump to prev undo node, undo to that state
    ['<cr>'] = "action_enter",  -- undo to the current undo state
    ['p'] = "enter_diffbuf",    -- preview diff of current undo node with current state
    ['q'] = "quit",             -- quit undotree
  },
})


-- define keymaps
vim.keymap.set('n', '<leader>ut', require('undotree').toggle, { noremap = true, silent = true })
-- register whichkey mappings
local wk_ok, wk = pcall(require, 'which-key')
if wk_ok then
  wk.register({
    ["<leader>ut"] = { require('undotree').toggle, "Toggle Undo Tree" },
  })
end
