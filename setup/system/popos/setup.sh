#!/usr/bin/bash
# dev env setup script for Pop_OS! (barebones)

echo """

##################################################
# SETTING UP DEVELOPMENT ENVIRONMENT FOR POP_OS! #
################################################## 

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
