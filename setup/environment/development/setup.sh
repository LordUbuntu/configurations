#!/usr/bin/env bash
# This script runs setup commands and automatically configures the environment for my programming/development environment
# TODO this needs to be reworked to be distro agnostic
# idea: this script will redirect to and run a setup script for a particular distro, rather than try to juggle for all of them


# distro particular dev setup
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





# distro agnostic dev setup

echo """

##### SETTING UP ZSH #####"""
if [[ $SHELL == "/bin/zsh" ]]
then
  echo "zsh already installed and set as default shell, skipping..."
elif [[ -f `which zsh` ]] && [[ $SHELL == "/bin/zsh" ]]
then
  echo "changing default shell for $(whoami) to zsh..."
  sudo chsh -s /bin/zsh $(whoami)
else
  echo "zsh not installed, skipping..."
fi
echo """##### DONE #####"""





echo """

##### SETTING UP SSH FOR GIT #####"""
if [[ -f `which git` ]]
then
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
else
  echo """##### SKIPPING GIT, NOT INSTALLED #####"""
fi
echo """##### DONE #####"""
