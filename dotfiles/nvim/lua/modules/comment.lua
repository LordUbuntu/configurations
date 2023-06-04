-- comment: smart and powerful comment plugin for nvim
-- see: https://github.com/numToStr/Comment.nvim

-- register declarative lazy.nvim config
return {
  'numToStr/Comment.nvim',
  keys = {
    'gcc',
    'gbc',
    'gc',
    'gb',
    'gcO',
    'gco',
    'gcA',
  },
  opts = {
    ---Add a space b/w comment and the line
    ---@type boolean|fun():boolean
    padding = true,
    ---Whether the cursor should stay at its position
    ---This only affects NORMAL mode mappings and doesn't work with dot-repeat
    ---@type boolean
    sticky = true,
    ---Lines to be ignored while comment/uncomment.
    ---Could be a regex string or a function that returns a regex string.
    ---Example: Use '^$' to ignore empty lines
    ---@type string|fun():string
    ignore = nil,
    ---LHS of toggle mappings in NORMAL + VISUAL mode
    ---@type table
    toggler = {
      ---Line-comment toggle keymap
      line = 'gcc',
      ---Block-comment toggle keymap
      block = 'gbc',
    },
    ---LHS of operator-pending mappings in NORMAL + VISUAL mode
    ---@type table
    opleader = {
      ---Line-comment keymap
      line = 'gc',
      ---Block-comment keymap
      block = 'gb',
    },
    ---LHS of extra mappings
    ---@type table
    extra = {
      ---Add comment on the line above
      above = 'gcO',
      ---Add comment on the line below
      below = 'gco',
      ---Add comment at the end of line
      eol = 'gcA',
    },
    ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
    --- If `mappings = false` then the plugin won't create any mappings
    ---@type boolean|table
    mappings = {
      ---Operator-pending mapping
      ---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
      ---These mappings can be changed individually by `opleader` and `toggler` config
      basic = true,
      ---Extra mapping
      ---Includes `gco`, `gcO`, `gcA`
      extra = true,
      ---Extended mapping
      ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
      extended = false,
    },
  },
}