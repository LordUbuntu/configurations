#!/usr/bin/env bash
# This script runs setup commands and automatically configures the environment for my programming/development environment based on what distro is currently running


# install common dev packages

##########################
# PACKAGE SPECIFIC SETUP #
##########################

# development_packages=(
  # # tools
  # zsh
  # git
  # ssh
  # nvim
  # emacs
  # micro
  # universal-ctags
#
  # # languages
  # python
  # python-pip
  # cabal-install
# )
echo """

#######################################
# SETTING UP PACKAGES FOR DEVELOPMENT #
#######################################

"""
pushd package >/dev/null
source install.sh
popd >/dev/null


###########################
# LANGUAGE SPECIFIC SETUP #
###########################

# development_languages=(
  # python
  # haskell
# )
echo """

#################################
# SETTING UP SELECTED LANGUAGES #
#################################

"""
for language in ${development_languages[@]}
do
  file="setup_$language.sh"
  if [[ -f language/$file ]]
  then
    source language/$file
  else
    echo "$file doesn't exist for $language, skipping!"
  fi
done





#######################
# TOOL SPECIFIC SETUP #
#######################

echo """

####################
# SETTING UP TOOLS #
####################

"""


# setup zsh
if [[ `command -v zsh` ]]
then
  echo """
##### SETTING UP ZSH #####"""
  if [[ $SHELL == "/bin/zsh" ]]
  then
    echo "zsh already installed and set as default shell, skipping..."
  else
    echo "changing default shell for $(whoami) to zsh..."
    sudo chsh -s $(command -v zsh) $(whoami)
  fi
  echo """##### DONE #####
  """
else
  echo """
##### SKIPPING ZSH, NOT INSTALLED #####
  """
fi


# setup ssh for git
if [[ `command -v git` ]]
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
  echo """##### DONE #####
  """
else
  echo """
##### SKIPPING GIT, NOT INSTALLED #####
  """
fi


# setup doom
if [[ `command -v emacs` ]]
then
  if [[ ! `command -v doom` ]]
  then
    echo """
##### SETTING UP DOOM FOR EMACS #####"""
    git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
    ~/.emacs.d/bin/doom install
    echo """##### DONE #####
    """
  fi
else
  echo """
##### SKIPPING DOOM, EMACS NOT INSTALLED #####
"""
fi
