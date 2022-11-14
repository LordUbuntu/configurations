local ok, indentblankline = pcall(require, "indent-blankline")
if not ok then
  return
end


vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

require("indent_blankline").setup {
  space_char_blankline = " ",
  show_current_context = true,
  show_current_context_start = true,
  -- show_first_indent_level = false,
  -- use_treesitter = true,
}
