-- Themes:
-- * gruvbox: https://github.com/ellisonleao/gruvbox.nvim
-- * catppuccin: https://github.com/catppuccin/nvim
-- * rose-pine: https://github.com/rose-pine/neovim
-- * oh-lucy: https://github.com/Yazeed1s/oh-lucy.nvim
return {
  -- gruvbox: a warm bright theme with pastel 'retro groove' colors
  --          inspired by badwolf, jellybeans, and solarized.
  -- see: https://github.com/ellisonleao/gruvbox.nvim
  {
    'ellisonleao/gruvbox.nvim',
    name = 'gruvbox',
    lazy = true,
    priority = 1000,
    opts = {
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = "", -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = false,
    },
  },
  -- catppuccin:  Catppuccin is a community-driven pastel theme that aims to be
  --              the middle ground between low and high contrast themes. It
  --              consists of 4 soothing warm flavors with 26 eye-candy colors
  --              each, perfect for coding, designing, and much more!
  -- see: https://github.com/catppuccin/nvim
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    priority = 1000,
    config = function()
      vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
    end,
  },
  -- rose-pine: All natural pine, faux fur and a bit of soho vibes
  --            for the classy minimalist.
  -- see: https://github.com/rose-pine/neovim
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = true,
    priority = 1000,
    config = function()
      local ok, rosepine = pcall(require, 'rose-pine')
      if not ok then
        return
      end

      rosepine.setup({
        --- @usage 'auto'|'main'|'moon'|'dawn'
        variant = 'auto',
        --- @usage 'main'|'moon'|'dawn'
        dark_variant = 'moon',
        bold_vert_split = false,
        dim_nc_background = false,
        disable_background = false,
        disable_float_background = false,
        disable_italics = false,

        --- @usage string hex value or named color from rosepinetheme.com/palette
        groups = {
          background = 'base',
          background_nc = '_experimental_nc',
          panel = 'surface',
          panel_nc = 'base',
          border = 'highlight_med',
          comment = 'muted',
          link = 'iris',
          punctuation = 'subtle',

          error = 'love',
          hint = 'iris',
          info = 'foam',
          warn = 'gold',

          headings = {
            h1 = 'iris',
            h2 = 'foam',
            h3 = 'rose',
            h4 = 'gold',
            h5 = 'pine',
            h6 = 'foam',
          }
          -- or set all headings at once
          -- headings = 'subtle'
        },

        -- Change specific vim highlight groups
        -- https://github.com/rose-pine/neovim/wiki/Recipes
        highlight_groups = {
          ColorColumn = { bg = 'rose' },

          -- Blend colours against the "base" background
          CursorLine = { bg = 'foam', blend = 10 },
          StatusLine = { fg = 'love', bg = 'love', blend = 10 },
        }
      })
    end,
  },
  -- oh-lucy: a soft and clear warm theme
  -- see: https://github.com/Yazeed1s/oh-lucy.nvim
  {
    'Yazeed1s/oh-lucy.nvim',
    name = 'oh-lucy',
    lazy = true,
    config = function()
      vim.g.oh_lucy_italic_comments = true
      vim.g.oh_lucy_italic_keywords = true
      vim.g.oh_lucy_italic_booleans = false
      vim.g.oh_lucy_italic_functions = false
      vim.g.oh_lucy_italic_variables = true
      vim.g.oh_lucy_transparent_background = false
    end,
  },
  -- darkman: A neovim plugin for interfacing with the freedesktop
  --          dark mode standard
  -- see:
  --  https://github.com/4e554c4c/darkman.nvim
  --  https://darkman.whynothugo.nl/
  {
    '4e554c4c/darkman.nvim',
    event = 'VeryLazy',
    build = 'go build -o bin/darkman.nvim',
    config = function()
      require("darkman").setup({})
    end,
  },
}
