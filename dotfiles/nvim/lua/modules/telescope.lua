-- telescope: find anything
-- telescope: https://github.com/nvim-telescope/telescope.nvim
return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.0',
  cmd = 'Telescope',
  dependencies = {
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
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
    local builtin = require('telescope.builtin')
    local themes = require('telescope.themes')

    builtin.find_files(themes.get_cursor())
  end,
}
