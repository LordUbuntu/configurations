#!/usr/bin/bash
# top-level install script

packages=(
  # media
  mpv
  ffmpeg
  youtube-dl
  mpd
  mpc
  ncmpcpp
)

pushd . > /dev/null
if [[ -f `which apt` ]]
then
  source distro/popos_install.sh
elif [[ -f `which yay` ]]
then
  source distro/manjaro_install.sh
fi
popd > /dev/null
