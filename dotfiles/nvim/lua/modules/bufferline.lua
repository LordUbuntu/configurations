-- bufferline:  A snazzy nail_care buffer line (with tabpage integration)
--              for Neovim built using lua.
-- see: https://github.com/akinsho/bufferline.nvim
return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  dependencies = 'nvim-tree/nvim-web-devicons',
  version = '*',
  config = function()
    require('bufferline').setup({})
  end,
}
