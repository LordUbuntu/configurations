#!/bin/sh
# attempt to install all binaries using whatever package manager is available


# global dependencies
# unzip
# wget
# curl
# gzip
# tar
# bash
# sh
# git
# gcc

programs="
bash
curl
gcc
git
gzip
sh
tar
unzip
wget
"



if [ $(command -v apt) ]
then
  # substitute programs with weird names like bat -> bat-cat
  # install packages
  sudo apt install "$programs"
elif [ $(command -v dnf) ]
then
  sudo dnf install "$programs"
elif [ $(command -v pacman) ]
then
  sudo pacman -suy "$programs"
fi
