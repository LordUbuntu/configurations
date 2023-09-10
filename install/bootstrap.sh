#!/bin/sh
# This script will setup environment for all installed programs



echo """
#################
# BOOTSTRAPPING #
#################
"""



echo """
======= GIT =======
"""
# setup git if/once it is installed
if [ $(command -v git) ]
then
  if [ "$(git config user.email)" = "" ]
  then
    read -rp "Git user email: " email
    git config --global user.email "$email"
  fi
else
  echo "!!! GIT not installed !!!"
  exit 1
fi



echo """
======= SSH =======
"""
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
  echo "!!! SSH not installed !!!"
  exit 1
fi



echo """
======= ZSH =======
"""
if [ $(command -v zsh) ]
then
  if [ $(basename "$SHELL") != zsh ]
  then
    echo "Changing default shell of $USER to $(command -v zsh)"
    echo "sudo chsh -s \"$(command -v zsh)\" \"$USER\""
    sudo chsh -s "$(command -v zsh)" "$USER"
  fi
else
  echo "!!! ZSH not installed !!!"
  exit 1
fi
