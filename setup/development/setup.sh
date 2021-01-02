#!/usr/bin/env bash
# This script runs setup commands and automatically configures the environment for my programming/development environment based on what distro is currently running


# install common dev packages
source package/install.sh


###########################
# LANGUAGE SPECIFIC SETUP #
###########################

languages=(
  python
  haskell
)
echo """

#################################
# SETTING UP SELECTED LANGUAGES #
#################################

"""
for language in ${languages[@]}
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
if [[ -f `which zsh` ]]
then
  echo """

##### SETTING UP ZSH #####"""
  if [[ $SHELL == "/bin/zsh" ]]
  then
    echo "zsh already installed and set as default shell, skipping..."
  else
    echo "changing default shell for $(whoami) to zsh..."
    sudo chsh -s $(which zsh) $(whoami)
  fi
  echo """##### DONE #####"""
else
  echo """##### SKIPPING ZSH, NOT INSTALLED #####"""
fi


# setup ssh for git
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


# setup doom
if [[ -f `which emacs` ]]
then
  echo """

##### SETTING UP DOOM FOR EMACS #####"""
  git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
  ~/.emacs.d/bin/doom install
  echo """##### DONE #####"""
else
  echo """##### SKIPPING DOOM, EMACS NOT INSTALLED #####"""
fi
