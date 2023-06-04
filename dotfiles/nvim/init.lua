-- enable caching
vim.loader.enable()

require("core.option")

require("core.keymap")

-- WARNING: leader key must be mapped before lazy.setup is called
require("core.lazy")

-- set colorscheme
local colorscheme = require("core.helpers").theme("gruvbox")
vim.cmd.colorscheme(colorscheme)
