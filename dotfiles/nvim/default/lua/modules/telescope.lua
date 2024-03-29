-- telescope: find anything
-- telescope: https://github.com/nvim-telescope/telescope.nvim
return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.0',
  cmd = 'Telescope',
  keys = {
    { '<leader>fb', '<cmd>Telescope buffers<cr>',    desc = 'Find Buffer' },
    { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find File' },
    { '<leader>fg', '<cmd>Telescope live_grep<cr>',  desc = 'Find Pattern' },
    { '<leader>fm', '<cmd>Telescope marks<cr>',      desc = 'Find Mark' },
    { '<leader>ft', '<cmd>Telescope tags<cr>',       desc = 'Find Tag' },
  },
  dependencies = {
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      dependencies = {
        { "junegunn/fzf", build = "./install --bin" }
      },
      build = 'make',
      config = function()
        require('telescope').load_extension('fzf')
      end,
    },
    { 'nvim-lua/plenary.nvim' },
  },
  config = function()
    require('telescope').setup({
      defaults = {
        prompt_prefix = 'λ ',
        selection_caret = '→ ',
        layout_strategy = 'horizontal',
        layout_config = {
          horizontal = {
            prompt_position = 'top',
            preview_width = 0.6,
            results_width = 0.4,
          },
          vertical = { mirror = false },
          width = 0.90,
          height = 0.80,
          preview_cutoff = 60,
        },
        path_display = { 'truncate' },
        border = {},
      },
      pickers = {
        -- ...
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
      },
    })
  end,
}
