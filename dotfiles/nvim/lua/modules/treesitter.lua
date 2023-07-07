-- nvim-treesitter: treesitter config and abstraction layer for nvim
-- see:
-- * nvim-treesitter:
--     https://github.com/nvim-treesitter/nvim-treesitter
-- * nvim-ts-autotag:
--     https://github.com/windwp/nvim-ts-autotag
-- * nvim-ts-context-commentstring:
--     https://github.com/JoosepAlviste/nvim-ts-context-commentstring
-- * HiPhish/rainbow-delimiters.nvim:
--     https://gitlab.com/HiPhish/rainbow-delimiters.nvim
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    -- nvim-ts-autotag: use treesitter to auto close and auto rename html tags
    -- see: https://github.com/windwp/nvim-ts-autotag
    {
      'windwp/nvim-ts-autotag',
    },
    -- nvim-ts-context-commentstring: set comentstring based on cursor location
    -- see: https://github.com/JoosepAlviste/nvim-ts-context-commentstring
    {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    -- rainbow-delimiters: colour delimiters for easier tracking of pairs
    -- see: https://gitlab.com/HiPhish/rainbow-delimiters.nvim
    {
      'HiPhish/rainbow-delimiters.nvim',
      enabled = true,
      dependencies = 'nvim-treesitter/nvim-treesitter',
      event = 'UIEnter',
      init = function()
        vim.cmd[[
          au ColorScheme gruvbox highlight link RainbowDelimiterRed GruvboxRed
          au ColorScheme gruvbox highlight link RainbowDelimiterOrange GruvboxOrange
          au ColorScheme gruvbox highlight link RainbowDelimiterYellow GruvboxYellow
          au ColorScheme gruvbox highlight link RainbowDelimiterGreen GruvboxGreen
          au ColorScheme gruvbox highlight link RainbowDelimiterCyan GruvboxAqua
          au ColorScheme gruvbox highlight link RainbowDelimiterBlue GruvboxBlue
          au ColorScheme gruvbox highlight link RainbowDelimiterViolet GruvboxPurple
        ]]
      end,
      config = function()
        -- This module contains a number of default definitions
        local rainbow_delimiters = require 'rainbow-delimiters'
        vim.g.rainbow_delimiters = {
            strategy = {
                [''] = rainbow_delimiters.strategy['global'],
                vim = rainbow_delimiters.strategy['local'],
            },
            query = {
                [''] = 'rainbow-delimiters',
                lua = 'rainbow-blocks',
            },
            highlight = {
                'RainbowDelimiterRed',
                'RainbowDelimiterOrange',
                'RainbowDelimiterYellow',
                'RainbowDelimiterGreen',
                'RainbowDelimiterCyan',
                'RainbowDelimiterBlue',
                'RainbowDelimiterViolet',
            },
        }
      end,
    },
  },
  config = function()
    require('nvim-treesitter.configs').setup({
      -- i use _a lot_ of programming languages, these are the bare essentials
      ensure_installed = {
        'arduino',
        'bash',
        'bibtex',
        'c',
        'c_sharp',
        'cpp',
        'css',
        'go',
        'haskell',
        'html',
        'javascript',
        'json',
        'latex',
        'lua',
        'make',
        'markdown',
        'nix',
        'python',
        'regex',
        'rust',
        'toml',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
        'yaml',
      },
      sync_install = false,
      auto_install = true,
      -- modules
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,  -- may slow down editor
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',  -- default: gnn
          node_incremental = '<C-space>',  -- default: grn
          scope_incremental = false,  -- default: grc
          node_decremental = '<bs>',  -- default: grm
        },
      },
      autotag = {
        enable = true,
      },
      context_commentstring = {
        enable = true,
      },
    })
  end,
}
