configurations
|- scripts
|  |- bootstrap.sh  (install dependencies and setup environment like default shell)
|  \- setup.sh      (symlink file structure from dotfiles to $HOME)
|- dotfiles
|  \- (semantic file structure emulating $HOME as its root)
\- nix
   \- (all nix config files and other stuff)


- basically just bootstrap and then setup
