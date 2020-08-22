#!/usr/bin/env bash
# This script runs setup commands and automatically configures the environment for my programming/development environment





echo """

#####################################
# SETTING UP DEVELOPENT ENVIRONMENT #
#####################################

"""





echo """

##### SETTING UP PYTHON #####

"""
packages="neovim black flake8"
if [[ -f `which pip3` ]]
then
  echo "updating pip3 to latest version"
  pip3 install --upgrade pip
  if [[ $packages != "" ]]
  then
    echo "installing packages for python"
    pip3 install $packages
  fi
else
  echo """##### SKIPPING PYTHON, CABAL NOT INSTALLED #####"""
fi
echo """##### DONE #####"""





echo """

##### SETTING UP HASKELL #####

"""
packages=""
if [[ -f `which cabal` ]]
then
  echo "updating cabal to latest version"
  cabal update
  cabal install cabal-install
  if [[ $packages != "" ]]
  then
    echo "installing packages for haskell"
    cabal install $packages
  fi
else
  echo """##### SKIPPING HASKELL, CABAL NOT INSTALLED #####"""
fi
echo """##### DONE #####"""





echo """

##### SETTING UP ZSH #####

"""
if [[ -f `which zsh` ]]
then
  echo "changing default shell for $(whoami) to zsh..."
  sudo chsh -s /bin/zsh $(whoami)
else
  echo """##### SKIPPING ZSH, NOT INSTALLED #####"""
fi
echo """##### DONE #####"""
