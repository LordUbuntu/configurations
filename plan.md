echo $XDG_SESSION_TYPE
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
- setup and install home-manager as a potential extra
