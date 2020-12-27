Development
==
These are a collection of scripts that when run with `./setup.sh` or `bash setup.sh` will install packages and setup the environment that I use across systems/distros.

Process
--
Starting at the top-level script:
- run top-level script `setup.sh`.
- source top-level `install.sh` script
  - first manually install any packages that cannot be installed natively.
  - then defer to (source) an install script in the `distro` directory that will install the correct packages for a given base.
- source setup scripts for any selected languages. If that language does not have a script it will skip that language.
- configure development tools and environment
