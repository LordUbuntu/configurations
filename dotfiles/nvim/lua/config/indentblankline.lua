local ok, indentblankline = pcall(require, "indent_blankline")
if not ok then
  return
end


vim.opt.listchars = {
  space = '⋅',
  eol = '↴',
  tab = '  ⇥',
  trail = '…',
}
vim.opt.list = true


indentblankline.setup {
  enabled = true,
  show_end_of_line = true,
  use_treesitter = true,
  show_first_indent_level = false,
  show_current_context = true,
  show_current_context_start = true,
  context_char = "┃",
  char_blankline = "│",
  space_char_blankline = " ",
}
