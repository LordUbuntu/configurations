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
source_dir distro/agnostic_install.sh


# distro specific setup
echo """

#######################################
# INSTALLING DISTRO SPECIFIC PROGRAMS #
#######################################

"""
if [[ $(command -v apt) ]]
then
  source_dir distro/popos_install.sh
elif [[ $(command -v yay) ]]
then
  source_dir distro/manjaro_install.sh
fi
