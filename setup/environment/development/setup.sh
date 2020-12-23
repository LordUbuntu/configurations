#!/usr/bin/env bash
# This script runs setup commands and automatically configures the environment for my programming/development environment





echo """

######################################
# SETTING UP DEVELOPMENT ENVIRONMENT #
######################################

"""





echo """

##### SETTING UP PYTHON #####"""
packages="neovim black flake8"
if [[ -f `which pip3` ]]
then
  echo -e "\tupdating pip3 to latest version..."
  pip3 install --upgrade pip
  if [[ $packages != "" ]]
  then
    echo -e "\tinstalling packages for python..."
    pip3 install $packages
  fi
else
  echo """##### SKIPPING PYTHON, CABAL NOT INSTALLED #####"""
fi
echo """##### DONE #####"""





echo """

##### SETTING UP HASKELL #####"""
packages=""
if [[ -f `which cabal` ]]
then
  echo -e "\tupdating cabal to latest version..."
  cabal update
  cabal install cabal-install
  if [[ $packages != "" ]]
  then
    echo -e "\tinstalling packages for haskell..."
    cabal install $packages
  fi
else
  echo """##### SKIPPING HASKELL, CABAL NOT INSTALLED #####"""
fi
echo """##### DONE #####"""





echo """

##### SETTING UP ZSH #####"""
if [[ $SHELL == "/bin/zsh" ]]
then
  echo "zsh already installed and set as default shell, skipping..."
fi
if [[ -f `which zsh` ]]
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
