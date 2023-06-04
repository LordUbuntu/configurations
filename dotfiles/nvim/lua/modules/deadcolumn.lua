-- deadcolumn: get hissy as the cursor gets closer to the colorcolumn
-- see: https://github.com/Bekaboo/deadcolumn.nvim
return {
  'Bekaboo/deadcolumn.nvim',
  event = 'VeryLazy',
  opts = {
    scope = 'visible',  -- line, buffer, visible, cursor
    modes = { 'i', 'ic', 'ix', 'R', 'Rc', 'Rx', 'Rv', 'Rvc', 'Rvx' },
    blending = {
      threshold = 0.80,
      colorcode = '#000000',
      hlgroup = {
        'Normal',
        'background',
      },
    },
    warning = {
      alpha = 0.4,
      offset = 0,
      colorcode = '#FB4934',  -- gruvbox red
      hlgroup = {
        'Error',
        'background',
      },
    },
    extra = {
      follow_tw = nil,
    },
  },
  config = function()
    vim.opt.textwidth = 80
    vim.opt.colorcolumn = "81"
    vim.opt.formatoptions = vim.opt.formatoptions + "t"
  end,
}
