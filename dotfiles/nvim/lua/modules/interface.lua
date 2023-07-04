-- NeoVIm Graphical User Interface
return {
  -- bufferline:  A snazzy buffer line (with tabpage integration)
  --              for Neovim built using lua.
  -- see: https://github.com/akinsho/bufferline.nvim
  {
    'akinsho/bufferline.nvim',
    event = 'UIEnter',
    dependencies = 'nvim-tree/nvim-web-devicons',
    version = '*',
    opts = {}
  },
  -- colorizer plugin
  -- see: https://github.com/norcalli/nvim-colorizer.lua
  {
    'norcalli/nvim-colorizer.lua',
    event = 'FileType',
    config = function()
      require('colorizer').setup({
        '*',
      }, {
        css = true,
        css_fn = true,
      })
    end,
  },
  -- deadcolumn: get hissy as the cursor gets closer to the colorcolumn
  -- see: https://github.com/Bekaboo/deadcolumn.nvim
  {
    'Bekaboo/deadcolumn.nvim',
    event = 'UIEnter',
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
  },
  -- indent blankline: Add indentation guides to all lines
  -- see: https://github.com/lukas-reineke/indent-blankline.nvim
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'UIEnter',
    opts = {
      enabled = true,
      show_end_of_line = true,
      use_treesitter = true,
      show_first_indent_level = false,
      show_current_context = true,
      show_current_context_start = true,
      context_char = "┃",
      char_blankline = "│",
      space_char_blankline = " ",
    },
    config = function()
      vim.opt.listchars = {
        space = '⋅',
        eol = '↴',
        tab = '  ⇥',
        trail = '…',
      }
      vim.opt.list = true
    end,
  },
  -- nnn: use the unorthidox file manger in nvim
  -- see: https://github.com/luukvbaal/nnn.nvim
  {
    'luukvbaal/nnn.nvim',
    lazy = true,
    cmd = {
      'NnnExplorer',
      'NnnPicker',
    },
    config = function()
      require('nnn').setup()
    end,
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
    lazy = true,
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
    },
  },
}
