-- duck.nvim: add's a cure duck (or other animal) that wanders around your code
-- see: https://github.com/tamton-aquib/duck.nvim
local default_creature = '🐍'
local creatures = {
  '🐍', -- snake
  '🐉', -- dragon
  '🦄', -- unicorn
  '🐏', -- ram
  '🦐', -- ebi
  '🔥', -- fire elemental
}
return {
  {
    'tamton-aquib/duck.nvim',
    keys = {
      {
        '<leader>ds',
        function() require('duck').hatch('🐍', 2) end,
        desc = 'Hatch a snake to slither around your code',
      },
      {
        '<leader>dk',
        function() require('duck').cook() end,
        desc = 'Kill and eat the creature wandering your code',
      },
      {
        '<leader>dr',
        -- hatch a random animal
        function()
          local creature = creatures[math.random(#creatures)]
          require('duck').hatch(creature, math.random() + math.random(0, 5))
        end,
        desc = 'Hatch a random creature to wander your code',
      },
    },
  },
}
