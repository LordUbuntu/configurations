local M = {}

-- map keys
M.map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
  -- local ok, whichkey = pcall(require, 'which-key')
  -- if ok then
  --   whichkey.register({
  --     [lhs] = { name = desc },
  --   }, { mode = mode })
  -- end
end

-- attempt to get colorscheme if available
M.theme = function(name)
  local ok, _ = pcall(vim.cmd.colorscheme, name)
  if ok then
    return name
  end

  return "default"
end

return M
