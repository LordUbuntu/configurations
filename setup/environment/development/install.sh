#!/usr/bin/env bash
# install packages required for environment

if [[ -f `which apt` ]]
then
  packages="python3 python3-pip cabal-install zsh git"
  sudo apt install $packages
fi

if [[ -f `which yay` ]]
then
  packages="python3 python3-pip cabal-install zsh git"
  yay -S $packages
fi
