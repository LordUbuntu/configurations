-- Current Line which-key: show a popup of possible keybindings
-- see: https://github.com/folke/which-key.nvim
return {
  {
    'folke/which-key.nvim',
    event = "VeryLazy",
    dependencies = {
      -- legendary: a searchable legend of keymaps
      -- see: https://github.com/mrjones2014/legendary.nvim
      {
        'mrjones2014/legendary.nvim',
        dependencies = { 'kkharji/sqlite.lua' },
      },
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
      require('legendary').setup({
        which_key = {
          auto_register = true,
        },
      })

      require("which-key").register({
        ['<leader>'] = {
          b = {
            name = 'Buffer',
            c = { '<cmd>BufferLinePick<cr>', 'Choose Buffer' },
          },
          h = {
            name = 'Hop',
            a = { '<cmd>HopAnywhere<CR>', 'Hop to Anywhere' },
            l = { '<cmd>HopLine<CR>', 'Hop to Line' },
            w = { '<cmd>HopWord<CR>', 'Hop to Word' },
            p = { '<cmd>HopPattern<CR>', 'Hop to Pattern' },
          },
          m = {
            name = 'Mode',
            z = { '<cmd>ZenMode<cr>', 'Toggle Zen Mode' },
          },
          n = {
            name = 'N³',
            e = { '<cmd>NnnExplorer<cr>', 'Explore files with NNN' },
            p = { '<cmd>NnnPicker<cr>', 'Pick file with NNN' },
          },
          f = {
            name = 'Telescope',
            b = { '<cmd>Telescope buffers<cr>', 'Find Buffer' },
            f = { '<cmd>Telescope find_files<cr>', 'Find File' },
            g = { '<cmd>Telescope live_grep<cr>', 'Find Pattern' },
            m = { '<cmd>Telescope marks<cr>', 'Find Mark' },
            t = { '<cmd>Telescope tags<cr>', 'Find Tag' },
          },
          u = {
            name = 'Undo',
            t = { require('undotree').toggle, 'Toggle Undo Tree' },
          },
          -- f = { name = 'File' },
          -- d = { name = 'Delete/Close' },
          -- q = { name = 'Quit' },
          -- s = { name = 'Search' },
          -- l = { name = 'LSP' },
          -- u = { name = 'UI' },
          -- D = { name = 'Debugging' },
          -- g = { name = 'Git' },
          ['?'] = { name = 'Keymap Legend' },  -- TODO: use legendary.nvim
          L = { name = 'Lazy NVim' },
       }
      })
    end
  }
}
