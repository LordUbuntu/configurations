#!/bin/sh
# TODO: the install checks at the start of each should be moved into a func

# global dependencies
# unzip
# wget
# curl
# gzip
# tar
# bash
# sh
# git



echo """
#################
# BOOTSTRAPPING #
#################
"""



echo """
======= GIT =======
"""
# install git if it is not installed already
if [ ! $(command -v git) ]
then
  echo "GIT not installed, attempting to install GIT..."
  # "install git" or something using host-wrapper install function
fi
# setup git if/once it is installed
if [ $(command -v git) ]
then
  if [ "$(git config user.email)" = "" ]
  then
    read -rp "Git user email: " email
    git config --global user.email "$email"
  fi
else
  echo "!!! GIT failed !!!"
  exit 1
fi



echo """
======= SSH =======
"""
# install ssh if it is not installed already
if [ ! $(command -v ssh) ]
then
  echo "SSH not installed, attempting to install SSH..."
  # "install ssh" or something using host-wrapper install function
fi
if [ $(command -v ssh) ]
then
  if [ ! -f "$HOME/.ssh/id_rsa" ]
  then
    echo "Forging SSH keys for $USER with git email $(git config user.email)"
    ssh-keygen -t rsa -b 4096 -C "$(git config user.email)"
    ssh-add ~/.ssh/id_rsa
  fi
  if [ ! $(ps -p "$SSH_AGENT_PID" 2>/dev/null) ]
  then
    echo "Staring SSH agent"
    eval "$(ssh-agent -s)"
  fi
else
  echo "!!! SSH failed !!!"
  exit 1
fi



echo """
======= ZSH =======
"""
# install ssh if it is not installed already
if [ ! $(command -v zsh) ]
then
  echo "ZSH not installed, attempting to install ZSH..."
  # "install ssh" or something using host-wrapper install function
fi
if [ $(command -v zsh) ]
then
  if [ $(basename "$SHELL") != zsh ]
  then
    echo "Changing default shell of $USER to $(command -v zsh)"
    echo "sudo chsh -s \"$(command -v zsh)\" \"$USER\""
    sudo chsh -s "$(command -v zsh)" "$USER"
  fi
else
  echo "!!! ZSH failed !!!"
  exit 1
fi
