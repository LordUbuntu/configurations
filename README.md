# Configurations
This repository documents and tracks the configuration files (dotfiles) and environment/system setup scripts (setup) that I use to - in effect - make my environment portable.

## dotfiles
This directory contains configuration files for various programs I commonly use between my various systems, and a script to hard link these files to the current system (assuming that they are installed)

## setup
This directory contains various scripts that when run will setup the current running system for that particular system or environment.

# Usage
A typical setup on a fresh system will typically follow this procedure (starting at the root of the configurations repository tree)
```bash
$ cd dotfiles
$ ./sync.sh
$ cd ../setup/environment/development
$ ./install.sh
$ ./setup.sh
```

