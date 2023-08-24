#!/bin/sh
# install dependencies for nvim
echo "\e[34m========== INSTALLING - NVIM =========="



# ensure prerequisites met
echo "\e[34m===== Checking prerequisites"
if [ ! $(command -v curl) ]
then
  echo "\e[31mCRITICAL: curl is missing"
  exit 1
fi



# install and setup tree-sitter
echo "\e[34m===== Setting up tree-sitter"
PATH="$PATH:$HOME/.cargo/bin"  # setup path to avoid reinstalls
if [ ! $(command -v cargo) ]
then
  echo "\e[33mInstalling rust"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  if [ $? ]
  then
    echo "\e[33mDone rust"
  else
    echo "\e[31mCRITICAL: failed to install rust"
    exit 1
  fi
fi
if [ ! $(command -v tree-sitter) ]
then
  echo "\e[33mInstalling tree-sitter"
  cargo install tree-sitter-cli
  if [ $? ]
  then
    echo "\e[33mDone tree-sitter"
  else
    echo "\e[31mCRITICAL: failed to install tree-sitter"
    exit 1
  fi
fi



# install and setup pyenv to give neovim a Python 3 provider with virutalenv
echo "\e[34m===== Setting up Python 3 virutual environment"
PATH="$PATH:$HOME/.pyenv/bin/pyenv"  # setup path to avoid reinstalls
if [ ! $(command -v pyenv) ]
then
  echo "\e[33mInstalling pyenv"
  PYENV_GIT_TAG=v2.3.24 
  curl https://pyenv.run | bash
  if [ $? ]
  then
    echo "\e[32mDone pyenv"
  else
    echo "\e[31mCRITICAL: failed to install pyenv"
    exit 1
  fi
fi
# setup neovim3 pyenv if not already
if [ ! $(pyenv virtualenvs | grep 'neovim3' | awk '{print $1}') ]
then
  echo "\e[33mSetting up neovim3 virtual env"
  # install and create virtualenv
  pyenv install 3.10
  pyenv virtualenv neovim3
  # install packages in virtual env
  pyenv activate neovim3
  pip install pynvim neovim
  source deactivate
  if [ $? ]
  then
    echo "\e[32mDone virtualenv for neovim"
  else
    echo "\e[31mCRITICAL: failed to setup virutalenv for neovim"
    exit 1
  fi
fi



# TODO:
# - go build chain (darkman)



# finished
echo "\e[33mPATH=$PATH"
echo "\e[34m======================================="
