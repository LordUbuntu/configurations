Configurations
==
This repository documents and tracks the configuration files (dotfiles) and environment/system setup scripts (setup) that I use to, in effect, make my environment portable across time and space. It was born out of necessity because I cannot settle on less than two distros at any one time and I can't stop tinkering with my systems. And so before you lay the cumulative work of lots of thinking and programming: a cobbled collection of scripts and configuration files that in a somewhat sensible manner somehow succeed in providing some system consistency between distros I occasion.

Dotfiles
--
Configuration files for various programs commonly used between my various systems, along with a script to hard link these files to the running system.

Setup
--
Scripts that install packages and setup environment variables for a distro.

Usage
--
Simply run `bootstrap.sh` and the scripts will source and run the relevant bits of the system.

How It Works
==
The system since being simplified consists of a few scripts that:
* setup and install packages for the given distro
* setup and install packages for the programming languages
* setup of user environment programs
* synchronize dotfiles with local user
```
bootstrap.sh
  setup/system/popos/setup.sh
    setup/system/popos/manual.sh
  setup/dev/languages.sh
  setup/setup.sh
  dotfiles/sync.sh
```
