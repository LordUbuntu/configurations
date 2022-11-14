local ok, bufferline = pcall(require, "bufferline")
if not ok then
  return
end


bufferline.setup({
  options = {
    numbers = "ordinal",
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    color_icons = true,
    show_buffer_icons = true,
    show_buffer_default_icon = true,
    separator_style = "thick",
    always_show_bufferline = false,
    sort_by = 'id',
  }
})
