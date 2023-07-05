-- hop: nvim motions on speed! hop about at the speed of thought.
-- see: https://github.com/phaazon/hop.nvim
return {
  'phaazon/hop.nvim',
  lazy = true,
  branch = 'v2',
  keys = {
    { '<leader>ha', '<cmd>HopAnywhere<CR>', desc = 'Hop to Anywhere' },
    { '<leader>hl', '<cmd>HopLine<CR>', desc = 'Hop to Line' },
    { '<leader>hw', '<cmd>HopWord<CR>', desc = 'Hop to Word' },
    { '<leader>hp', '<cmd>HopPattern<CR>', desc = 'Hop to Pattern' },
  },
  config = function()
    require('hop').setup({})
  end,
}
