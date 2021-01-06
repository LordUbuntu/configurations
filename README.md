Configurations
==
This repository documents and tracks the configuration files (dotfiles) and environment/system setup scripts (setup) that I use to, in effect, make my environment portable across time and space. It was born out of necessity because I cannot settle on less than two distros at any one time and I can't stop tinkering with my systems. This system isn't perfect but it just so happens to be the semi-certainty of consistency that tech nomads such as myself seek. And so before you lay the cumulative work of lots of thinking and programming: a cobbled collection of scripts and configuration files that in a somewhat sensible manner somehow succeed in providing some system consistency between distros I occasion.


At least it's not written in PHP.

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
The entire system consists of scripts sourcing bits of other scripts depending on what programs and what distro are installed. Script-wise the bootstrap process sources and runs bash scripts in this order:
```
bootstrap.sh
setup/system/${current distro}/setup.sh
  setup/system/common/setup.sh
    setup/system/common/distro/install.sh
      setup/system/common/distro/agnostic_install.sh
      setup/system/common/distro/${current distro}_install.sh
setup/system/common/development/setup.sh
  setup/system/common/development/package/install.sh
    setup/system/common/development/package/${current distro}_install.sh
  setup/system/common/development/language/${languages}_install.sh
dotfiles/sync.sh
```
