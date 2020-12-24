#!/usr/bin/bash
# dev env setup script for Manjaro OS (barebones)

echo """

##################################################
# SETTING UP DEVELOPMENT ENVIRONMENT FOR MANJARO #
##################################################

"""

echo """

##### SETTING UP PYTHON #####"""
packages="neovim black flake8"
if [[ -f `which pip` ]]
then
  echo -e "\tupdating pip to latest version..."
  pip install --upgrade pip
  if [[ $packages != "" ]]
  then
    echo -e "\tinstalling packages for python..."
    pip install $packages
  fi
else
  echo """##### SKIPPING PYTHON, PIP NOT INSTALLED #####"""
fi
echo """##### DONE #####"""





echo """

##### SETTING UP HASKELL #####"""
packages="hlint"
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
