#!/usr/bin/bash
# system setup script

echo """

######################
# SETTING UP POP_OS! #
######################

"""

echo "##### INSTALLING PACKAGES #####"

packages="
  zsh
  git
  ssh
  shellcheck
  neovim
  emacs
  micro
  python3
  python3-pip
  cabal-install
  sbcl
  gcc
  g++
  mpv
  cmus
  picard
  ffmpeg
  youtube-dl
  zathura*
  alacritty
  obs-studio
  klavaro
  dwarf-fortress
  httpie
  exa
  bcal
  nnn
  cmatrix
  fd-find
  bat
  silversearcher-ag
  ripgrep
  ssh
  endlessh
  syncthing
  pandoc
  texlive
  texlive-xetex
  texlive-publishers
  texlive-latex-extra
  texlive-lang-*
  texlive-fonts-*
  fonts-hack
"
sudo apt install $packages
source manual.sh
