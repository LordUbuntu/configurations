#!/bin/sh
# This script will setup environment for all installed programs



echo """
#################
# BOOTSTRAPPING #
#################
"""



if [ ! $(command -v nix) ]
then
  # install dotfile dependencies
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
  # rustup

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
fi



# setup git if/once it is installed
if [ $(command -v git) ]
then
  if [ "$(git config user.email)" = "" ]
  then
    echo """
    ======= GIT =======
    """
    read -rp "Git user email: " email
    git config --global user.email "$email"
  fi
else
  echo "!!! GIT not installed !!!"
  exit 1
fi



if [ $(command -v ssh) ]
then
  if [ ! -f "$HOME/.ssh/id_rsa" ]
  then
    echo """
    ======= SSH =======
    """
    echo "Forging SSH keys for $USER with git email $(git config user.email)"
    ssh-keygen -t rsa -b 4096 -C "$(git config user.email)"
    ssh-add ~/.ssh/id_rsa
  fi
  if [ ! $(ps -p "$SSH_AGENT_PID" 2>/dev/null) ]
  then
    eval "$(ssh-agent -s)" &>/dev/null
  fi
else
  echo "!!! SSH not installed !!!"
  exit 1
fi



if [ $(command -v zsh) ]
then
  if [ $(basename "$SHELL") != zsh ]
  then
    echo """
    ======= ZSH =======
    """
    echo "Changing default shell of $USER to $(command -v zsh)"
    echo "sudo chsh -s \"$(command -v zsh)\" \"$USER\""
    sudo chsh -s "$(command -v zsh)" "$USER"
  fi
else
  echo "!!! ZSH not installed !!!"
  exit 1
fi