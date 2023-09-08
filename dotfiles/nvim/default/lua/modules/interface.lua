-- The looks of the editor
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
            virtualtext = "",
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
      vim.opt.wrap = true
      vim.opt.wrapmargin = 80
      -- vim.opt.textwidth = 0  -- set to 80 for hard newline break, 0 to not
      vim.opt.linebreak = true
      vim.opt.breakindent = true
      vim.opt.showbreak = '>> '
      vim.opt.colorcolumn = "80"
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
}
