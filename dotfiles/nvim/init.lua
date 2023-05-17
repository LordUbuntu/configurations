-- load plugins with packer
require('packer_init')

-- specialized configurations across files
require('core.option')
require('core.keymap')

-- theme
require('themes.monokai-pro')
-- vim.cmd [[ set background=light ]]  -- light theme


-- NOTES TO SELF:
-- move all configs to each config file so that it can be modular instead of depending on core stuff.
-- maybe remove core.* stuff, and maybe move core.* stuff into this init...
