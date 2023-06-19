-- nnn: use the unorthidox file manger in nvim
-- see: https://github.com/luukvbaal/nnn.nvim
return {
  'luukvbaal/nnn.nvim',
  lazy = true,
  cmd = {
    'NnnExplorer',
    'NnnPicker',
  },
  config = function()
    require('nnn').setup()
  end,
}
