-- duck.nvim: add's a cure duck (or other animal) that wanders around your code
-- see: https://github.com/tamton-aquib/duck.nvim
local animal = '🐍'
return {
  {
    'tamton-aquib/duck.nvim',
    keys = {
      {
        '<leader>dh',
        function() require('duck').hatch(animal or '🦆') end,
        desc = 'Hatch a creature to wander your code',
      },
      {
        '<leader>dk',
        function() require('duck').cook() end,
        desc = 'Cook and eat the creature wandering your code',
      },
    },
    config = function()
      vim.keymap.set('n', '<leader>dd', function() require("duck").hatch() end, {})
      vim.keymap.set('n', '<leader>dk', function() require("duck").cook() end, {})
    end,
  },
}
