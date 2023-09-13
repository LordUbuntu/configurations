Plan:
- start at toplevel install.sh script
- run general bootstrap (single bootstrap file in install directory, skips over installation if on nix, then proceeds towards setting up environment stuff, then finally next step)
- automatically run bootstrap.sh file in each subdirectory under dotfiles directory.


One of the running principles of this repo is that each program's config is reasonably self-contained so that it's a simple matter of installing the program and syncing config files.

There will be a place for startpages to be stored (from my AWE startpage repo. The idea is sync startpages and run them with daemon on machine locally, probably somewhere inside ~/.local or in a ~/.startpage directory)


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



At the beginning, setup will first check if system has nix, and if it does will start a setup script in the nix directory to use flakes and whatever.
If the system is arch/ubuntu/fedora, then it will do the usual task of running each bootstrap script in each dotfile directory.
In either case, dotfiles will be linked/copied to their respective paths on system. Only difference is in how dependencies/packages are handled.

Alternatively, it might be easier to have a separate file in install directory for arch, ubuntu, fedora, and nix that will automatically install all packages and sync all dotfiles for each respective system.
Or perhaps have a directory for each distribution with its respective 
files and everything to setup a seperate preferred system for each independently. Making this repo a superrepo with sub-repos dedicated to different os setups/configs.
Or it might be good to simplify this in the future by just having the one script for one system to install all packages and sync dotfiles.
