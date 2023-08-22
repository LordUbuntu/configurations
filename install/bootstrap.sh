#!/bin/sh


echo """
======= GIT =======
"""
if [ ! $(command -v git) ]
then
  echo "GIT not installed, attempting to install GIT..."
  # "install git" or something using host-wrapper install function
fi
if [ $(command -v git) ]
then
  # setup git configurations
else
  echo "!!! GIT was not installed, may need to be installed manually..."
fi
