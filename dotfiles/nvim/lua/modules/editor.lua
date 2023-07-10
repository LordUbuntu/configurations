-- The navigation, menus, and features of the editor
return {
  -- comment: smart quick comments for neovim
  -- see: https://github.com/numToStr/Comment.nvim
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
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
  },
  -- hop: nvim motions on speed! hop about at the speed of thought.
  -- see: https://github.com/phaazon/hop.nvim
  {
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
  },
  -- nnn: use the unorthidox file manger in nvim
  -- see: https://github.com/luukvbaal/nnn.nvim
  {
    'luukvbaal/nnn.nvim',
    cmd = {
      'NnnExplorer',
      'NnnPicker',
    },
    keys = {
      { '<leader>ne', '<cmd>NnnExplorer<cr>', desc = 'Explore files with NNN' },
      { '<leader>np', '<cmd>NnnPicker<cr>', desc = 'Pick file with NNN' },
    },
    config = function()
      require('nnn').setup()
    end,
  },
  -- nvim-surround: a plugin to surround selected text with whatever delimiters.
  -- see: https://github.com/kylechui/nvim-surround
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  -- vim-startuptime: a nicer startup time visualizer
  -- see: https://github.com/dstein64/vim-startuptime
  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
  },
  -- todo-comments plugin
  -- see: https://github.com/folke/todo-comments.nvim
  -- NOTE: ensure darkman is not lazy-loaded or todo-comments
  --       highlighting becomes non-deterministic.
  {
    -- FIX:
    -- WARN:
    -- HACK:
    -- INFO:
    -- TODO:
    -- PERF:
    -- TEST:
    'folke/todo-comments.nvim',
    event = 'UIEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('todo-comments').setup({})
      require('core.helpers').map('n', '<leader>xT', '<cmd>TodoTrouble<cr>',
        'Show Todo in Trouble')
      require('core.helpers').map('n', '<leader>xt', '<cmd>TodoTelescope<cr>',
        'Show Todo in Telescope')
    end,
  },
  -- undotree: navigate parallel universes in neovim
  -- see: https://github.com/jiaoshijie/undotree
  {
    'jiaoshijie/undotree',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      local undotree = require('undotree')
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

      require('core.helpers').map(
          'n', '<leader>ut', require('undotree').toggle, 'Toggle Undo Tree')
    end,
  },
}
