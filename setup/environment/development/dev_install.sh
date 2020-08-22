#!/usr/bin/env bash


if [[ -f `which apt` ]]
then
  packages="python3 python3-pip cabal-install zsh"
  sudo apt install $packages
fi

if [[ -f `which yay` ]]
then
  packages="python pip cabal-install zsh"
  yay -S $packages
fi
