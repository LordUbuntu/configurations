-- colorizer plugin
-- see: https://github.com/norcalli/nvim-colorizer.lua
return {
  'norcalli/nvim-colorizer.lua',
  event = 'VeryLazy',
  config = function()
    require('colorizer').setup({
      '*',
    }, {
      css = true,
      css_fn = true,
    })
  end,
}
