-- undotree: navigate parallel universes in neovim
-- see: https://github.com/jiaoshijie/undotree
return {
  'jiaoshijie/undotree',
  lazy = true,
  dependencies = 'nvim-lua/plenary.nvim',
  keys = '<leader>ut',
  opts = {
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
    }
}
