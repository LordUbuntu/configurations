#!/usr/bin/env bash
# This script runs setup commands and automatically configures the environment for my programming/development environment based on what distro is currently running





#########################
# DISTRO SPECIFIC SETUP #
#########################

pushd .
if [[ -f `which apt` ]]
then
  cd ../../system/popos/
  ./setup.sh
elif [[ -f `which yay` ]]
then
  cd ../../system/manjaro/
  ./setup.sh
elif [[ -f `which nix` ]]
then
  cd ../../system/nixos/
  ./setup.sh
fi
popd





#########################
# DISTRO AGNOSTIC SETUP #
#########################

if [[ -f `which zsh` ]]
then
  echo """

  ##### SETTING UP ZSH #####"""
  if [[ $SHELL == "/bin/zsh" ]]
  then
    echo "zsh already installed and set as default shell, skipping..."
  else
    echo "changing default shell for $(whoami) to zsh..."
    sudo chsh -s /bin/zsh $(whoami)
  fi
  echo """##### DONE #####"""
else
  echo """##### SKIPPING ZSH, NOT INSTALLED #####"""
fi





if [[ -f `which git` ]]
then
  echo """

  ##### SETTING UP SSH FOR GIT #####"""
  email="$(git config user.email)"
  if [[ $email == "" ]]
  then
    echo "please set git user.email, skipping!"
  else
    if [[ ! -f "$HOME/.ssh/id_rsa" ]]
    then
      echo "git installed and email set, setting up ssh..."
      ssh-keygen -t rsa -b 4096 -C "$email"
      eval "$(ssh-agent -s)"
      ssh-add ~/.ssh/id_rsa
    else
      echo "git installed, email set, and ssh setup, skipping..."
    fi
  fi
  # start an ssh agent if it doesn't exist
  ps -p $SSH_AGENT_PID > /dev/null || eval "$(ssh-agent -s)"
  echo """##### DONE #####"""
else
  echo """##### SKIPPING GIT, NOT INSTALLED #####"""
fi
