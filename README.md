# Configurations
This repository documents and tracks the configuration files (dotfiles) and environment/system setup scripts (setup) that I use to - in effect - make my environment portable across time and space.

## dotfiles
This directory contains configuration files for various programs I commonly use between my various systems, and a script to hard link these files to the current system.

## setup
This directory contains various scripts that when run will setup the current running system for that particular system or environment.

# Usage
Within different directories there are different scripts for different purposes. The top-level script for each directory is what should be run.
* In `dotfiles` run `sync.sh` to link configuration files to the system.
* In `setup/development` run `setup.sh` to setup common development packages and environment.
* In `setup/system/common` run `setup.sh` to setup common packages and programs.
* In `setup/system/*` run `setup.sh` to setup the system for that particular distro/base.

A typical setup procedure from scratch looks like this:
```bash
$ cd dotfiles
$ ./sync.sh
$ cd ../setup/development
$ ./setup.sh
```

