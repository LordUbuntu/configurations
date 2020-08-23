#!/usr/bin/env bash
# TODO merge into setup script

if [[ ! -f "$HOME/.ssh/id_rsa" ]]
then
  ssh-keygen -t rsa -b 4096 -C "therealjacoburger@gmail.com"

fi
ssh-keygen -t rsa -b 4096 -C "therealjacoburger@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

if [[ ! -f $(which git) ]]
then
  echo "git is not installed, skipping!"
else
  if [[ $(git config user.email) == "" ]]
  then
    echo "please set git user.email, skipping!"
  else
    email="$(git config user.email)"
    if [[ ! -f "$HOME/.ssh/id_rsa" ]]
    then
      echo "git installed and email set, setting up ssh..."
      ssh-keygen -t rsa -b 4096 -C "$email"
      eval "$(ssh-agent -s)"
      ssh-add ~/.ssh/id_rsa
    fi
  fi
  # start an ssh agent if it doesn't exist
  ps -p $SSH_AGENT_PID > /dev/null || eval "$(ssh-agent -s)"
fi
