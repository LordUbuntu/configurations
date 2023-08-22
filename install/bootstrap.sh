#!/bin/sh
# TODO: the install checks at the start of each should be moved into a func



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
    ssh-keyget -t rsa -b 4096 -C "$(git config user.email)"
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
