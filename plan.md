One of the running principles of this repo is that each program's config is reasonably self-contained so that it's a simple matter of installing the program and syncing config files.

configurations
|- install
|  |- bootstrap.sh  (install universal deps and env, needed for setup)
|  \- setup.sh      (setup each dotfiles subdir from programs specified)  
|- dotfiles
|  \- (each folder contains config files along with a deps and links file
|      to specify where each file will be linked to and automatically
|      install packages and dependencies (or build manually if needed).
|      This will only be done for files specified in the install setup.
\- nix
   \- (all nix config files and other stuff)


- basically just bootstrap and then setup

future:
- reconfigure install and setup scripts from toplevel to defer to nixos or fedora/debian/arch setups based on current system
- detox off pyenv with python venv instead (for nvim, setup venv in a predictable place in $HOME directory)
- setup and install home-manager as a potential extra
