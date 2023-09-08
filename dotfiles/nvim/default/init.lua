-- enable caching
vim.loader.enable()


-- load options
require("core.option")


-- load keymaps
require("core.keymap")


-- WARNING: leader key must be mapped before lazy.setup is called
require("core.lazy")


-- set colorscheme
vim.cmd.colorscheme(require("core.helpers").try_colorscheme("gruvbox"))
