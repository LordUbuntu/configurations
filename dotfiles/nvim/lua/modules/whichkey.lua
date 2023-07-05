-- Current Line which-key: show a popup of possible keybindings
-- see: https://github.com/folke/which-key.nvim
return {
  {
    'folke/which-key.nvim',
    event = "VeryLazy",
    dependencies = {
      -- dressing: improve default vim.ui interfaces
      -- see: https://github.com/stevearc/dressing.nvim
      {
        'stevearc/dressing.nvim',
      },
    },
    opts = {
      plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
          enabled = true, -- show whichkey when pressing z= spell correct combo
          suggestions = 20, -- how many suggestions should be shown?
        },
      },
      window = {
        border = "single", -- none, single, double, shadow
        position = "bottom", -- bottom, top
      },
      show_help = true, -- show help message on the command line when the popup is visible
      triggers = "auto", -- automatically setup triggers
      -- triggers = {"<leader>"} -- or specify a list manually
    },
    -- keep all plugin keymap registries here
    config = function()
      require("which-key").register({
        ['<leader>'] = {
          b = { name = 'Buffer' },
          D = { name = 'Debug' },
          f = { name = 'Find' },
          g = { name = 'Git' },
          h = { name = 'Hop' },
          l = { name = 'LSP' },
          L = { name = 'Lazy' },
          m = { name = 'Mode' },
          M = { name = 'Mason' },
          n = { name = 'N³' },
          u = { name = 'Undo' },
       }
      })
    end
  }
}
