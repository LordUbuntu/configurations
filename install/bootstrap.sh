#!/bin/sh

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
  if [ $(git config user.email) == "" ]
  then
    read -rp "git user email: " email
    git config --global user.email "$email"
  fi
else
  echo "!!! GIT was not installed, may need to be installed and setup manually..."
  exit 1
fi



