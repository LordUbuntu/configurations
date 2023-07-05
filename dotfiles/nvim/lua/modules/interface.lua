-- NeoVIm Graphical User Interface
-- TODO: replace colorizer with CCC
return {
  -- bufferline:  A snazzy buffer line (with tabpage integration)
  --              for Neovim built using lua.
  -- see: https://github.com/akinsho/bufferline.nvim
  {
    'akinsho/bufferline.nvim',
    event = 'UIEnter',
    keys = {
      { '<leader>bc', '<cmd>BufferLinePick<cr>', desc = 'Choose Buffer' },
    },
    dependencies = 'nvim-tree/nvim-web-devicons',
    version = '*',
    opts = {}
  },
  -- colorizer plugin
  -- see: https://github.com/norcalli/nvim-colorizer.lua
  {
    'NvChad/nvim-colorizer.lua',
    event = 'UIEnter',
    keys = {
      { '<leader>uc', '<cmd>ColorizerToggle<cr>', desc = 'Toggle Colorizer' }
    },
    config = function()
      require("colorizer").setup({
          filetypes = { "*", 'html', 'css', 'js' },
          user_default_options = {
            RGB = true, -- #RGB
            RRGGBB = true, -- #RRGGBB
            names = true, -- "Name" codes like Blue or blue
            RRGGBBAA = true, -- #RRGGBBAA
            AARRGGBB = true, -- 0xAARRGGBB
            rgb_fn = true, -- CSS rgb(), rgba()
            hsl_fn = true, -- CSS hsl(), hsla()
            css = true, -- Enable all CSS features
            css_fn = true, -- Enable all CSS *functions*
            -- Available modes for `mode`: foreground, background,  virtualtext
            mode = "virtualtext",
            virtualtext = "⏺",
            tailwind = true,
            -- parsers can contain values used in |user_default_options|
            sass = { enable = true, parsers = { "css" }, }, -- Enable sass colors
            always_update = true,
          },
          -- all the sub-options of filetypes apply to buftypes
          buftypes = {},
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
  -- dressing: improve default vim.ui interfaces
  -- see: https://github.com/stevearc/dressing.nvim
  {
    'stevearc/dressing.nvim',
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
