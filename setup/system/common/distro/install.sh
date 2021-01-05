#!/usr/bin/bash
# top-level install script

# available in toplevel
# common_packages=(
  # # media
  # mpv
  # ffmpeg
  # youtube-dl
# )

# distro agnostic setup
echo """

#######################################
# INSTALLING DISTRO AGNOSTIC PROGRAMS #
#######################################

"""
pushd . >/dev/null
source distro/agnostic_install.sh
popd >/dev/null


# distro specific setup
echo """

#######################################
# INSTALLING DISTRO SPECIFIC PROGRAMS #
#######################################

"""
pushd . >/dev/null
if [[ `command -v apt` ]]
then
  source distro/popos_install.sh
elif [[ `command -v yay` ]]
then
  source distro/manjaro_install.sh
fi
popd >/dev/null
