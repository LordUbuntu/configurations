local M = {}

-- map keys
M.map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

-- TODO: future map replacement
-- NOTE: opts is a table of options like buffer, desc, silent, etc
M.mmap = function(mode, lhs, rhs, opts)
  opts.silent = opts.silent or true
  vim.keymap.set(mode, lhs, rhs, opts)
end

M.lsp_map = function(lhs, rhs, bufnr, desc)
  vim.keymap.set('n', lhs, rhs, { silent = true, buffer = bufnr, desc = desc })
end

-- attempt to get colorscheme if available
M.try_colorscheme = function(name)
  local ok, _ = pcall(vim.cmd.colorscheme, name)
  if ok then
    return name
  end

  return "default"
end

return M
