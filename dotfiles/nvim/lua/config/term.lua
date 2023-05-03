-- plugin: toggleterm
-- url: https://github.com/akinsho/toggleterm.nvim
local ok, term = pcall(require, 'toggleterm')
if not ok then
  return
end


-- setup plugin
term.setup({})
