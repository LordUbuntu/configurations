#!/usr/bin/env bash
# top-level install script


#############################
# DISTRO SPECIFIC PROCEDURE #
#############################

echo """

###################################################
# INSTALLING DISTRO SPECIFIC DEVELOPMENT PACKAGES #
###################################################

"""

if [[ `command -v apt` ]]
then
  source popos_install.sh
elif [[ `command -v yay` ]]
then
  source manjaro_install.sh
fi
