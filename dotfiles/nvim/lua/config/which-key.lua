local ok, wk = pcall(require, "which-key")
if not ok then
  return
end


-- setup plugin
wk.setup({
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- show whichkey when pressing z= spell correct combo
      suggestions = 20, -- how many suggestions should be shown?
    },
  },
  window = {
    border = "double", -- none, single, double, shadow
    position = "bottom", -- bottom, top
  },
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
})
