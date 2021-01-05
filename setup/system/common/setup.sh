#!/usr/bin/bash
# this shell script sets up the most common packages used between all distros
# make sure to exclude nixos, since it does things rather differently. it may be included again in the future with home-manager but even then the setup would be deferred to /system/nixos instead of /common/setup
# this script should also call the system specific common installation script, which will install any packages common to all systems, for that particular system

# install common packages
source distro/install.sh
