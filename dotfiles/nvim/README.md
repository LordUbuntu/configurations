# My Neovim Setup

This directory contains all the files I use for my Neovim setup.

+ `init.lua` is the top-most config
+ `lua/packer_init.lua` is the packages
+ `lua/themes` are where the themes go
+ `lua/config` is where plugin specific configurations go
+ `lua/core` is where core modules go (like keymaps)

Not everything is Neovim ready though, so there are some Vim files here as well to compensate for that. The `syntax` and `ftdetect` directories are for those situations that aren't yet covered. Mostly, just files that I work with on occasion. For very special cases (like apl), there are special keymaps in `keymap`
