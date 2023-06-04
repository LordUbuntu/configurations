-- hop: nvim motions on speed! hop about at the speed of thought.
-- see: https://github.com/phaazon/hop.nvim
return {
  'phaazon/hop.nvim',
  lazy = true,
  branch = 'v2',
  cmd = {
    'HopWord',
    'HopLine',
    'HopPattern',
    'HopAnywhere',
  },
  config = function()
    require('hop').setup({})
  end,
}
