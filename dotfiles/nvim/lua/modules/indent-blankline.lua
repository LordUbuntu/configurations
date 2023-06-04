-- indent blankline: Add indentation guides to all lines
-- see: https://github.com/lukas-reineke/indent-blankline.nvim
return {
  'lukas-reineke/indent-blankline.nvim',
  event = 'VeryLazy',
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
}
