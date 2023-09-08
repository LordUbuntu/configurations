#!/bin/sh
# Jacobus Burger (2023)
# Setup script to install prerequisite programs for neovim to function properly
echo "\e[34m========== INSTALLING - NVIM ==========\e[0m"



# ensure prerequisites met
# givens:
# grep
# awk
# rm
# sudo
# tar
# an internet connection
echo "\e[34m===== Checking prerequisites\e[0m"
if [ ! $(command -v curl) ]
then
  echo "\e[31mCRITICAL: curl is missing\e[0m"
  exit 1
fi
if [ ! $(command -v git) ]
then
  echo "\e[31mCRITICAL: git is missing\e[0m"
  exit 1
fi
if [ ! $(command -v cmake) ]
then
  echo "\e[31mCRITICAL: cmake is missing\e[0m"
  exit 1
fi
if [ ! $(command -v tar) ]
then
  echo "\e[31mCRITICAL: tar is missing\e[0m"
  exit 1
fi



# install and setup tree-sitter
echo "\e[34m===== Setting up tree-sitter\e[0m"
PATH="$PATH:$HOME/.cargo/bin"  # setup path to avoid reinstalls
if [ ! $(command -v cargo) ]
then
  echo "\e[33mInstalling rust\e[0m"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  if [ $? ]
  then
    echo "\e[33mDone rust\e[0m"
  else
    echo "\e[31mCRITICAL: failed to install rust\e[0m"
    exit 1
  fi
fi
if [ ! $(command -v tree-sitter) ]
then
  echo "\e[33mInstalling tree-sitter\e[0m"
  cargo install tree-sitter-cli
  if [ $? ]
  then
    echo "\e[33mDone tree-sitter\e[0m"
  else
    echo "\e[31mCRITICAL: failed to install tree-sitter\e[0m"
    exit 1
  fi
fi



# install and setup pyenv to give neovim a Python 3 provider with virutalenv
echo "\e[34m===== Setting up Python 3 virutual environment"
PATH="$PATH:$HOME/.pyenv/bin/pyenv"  # setup path to avoid reinstalls
if [ ! $(command -v pyenv) ]
then
  echo "\e[33mInstalling pyenv\e[0m"
  PYENV_GIT_TAG=v2.3.24 
  curl https://pyenv.run | bash
  if [ $? ]
  then
    echo "\e[32mDone pyenv\e[0m"
  else
    echo "\e[31mCRITICAL: failed to install pyenv\e[0m"
    exit 1
  fi
  unset PYENV_GIT_TAG
fi
# setup neovim3 pyenv if not already
if [ ! $(pyenv virtualenvs | grep 'neovim3' | awk '{print $1}') ]
then
  echo "\e[33mSetting up neovim3 virtual env\e[0m"
  # WARNING: untested
  # install and create virtualenv
  python -m venv "$HOME/.virtualenvs/neovim3"
  source "$HOME/.virtualenvs/neovim3/bin/activate"
  # install packages in virtual env, assuming we're currently in one
  pip install pynvim neovim
  deactivate
  if [ $? ]
  then
    echo "\e[32mDone virtualenv for neovim\e[0m"
  else
    echo "\e[31mCRITICAL: failed to setup virutalenv for neovim\e[0m"
    exit 1
  fi
fi



# install and setup go for darkman
echo "\e[34m===== Setting up darkman\e[0m"
PATH="$PATH:/usr/local/go/bin"  # setup path to avoid reinstalls
VERSION=1.21.0
ARCH=amd64
if [ ! $(command -v go) ]
then
  echo "\e[33mInstalling go\e[0m"
  # download latest
  curl -O -L "https://golang.org/dl/go$VERSION.linux-$ARCH.tar.gz"
  # TODO: determine how paranoid this per-step check is, and maybe put it
  # everywhere if it isn't?
  [ ! $? ] && echo "\e[31mCRITICAL: failed to install go\e[0m" && exit 1
  # remove any previous installations and untar to /usr/local/go.
  # DO NOT UNTAR INTO EXISTING GO INSTALLATIONS
  echo "\e[31mNEED SUDO TO INSTALL GO:\e[0m"
  echo "\e[31msudo rm -rf /usr/local/go\e[0m"
  echo "\e[31msudo tar -C /usr/local -xzf \"go$VERSION.linux-$ARCH.tar.gz\"\e[0m"
  sudo rm -rf /usr/local/go
  sudo tar -C /usr/local -xzf "go$VERSION.linux-$ARCH.tar.gz"
  # clean up
  rm "go$VERSION.linux-$ARCH.tar.gz"
  if [ $? ]
  then
    echo "\e[32mDone installing go\e[0m"
  else
    echo "\e[31mCRITICAL: failed to install go\e[0m"
    exit 1
  fi
fi
unset VERSION ARCH



# install and setup fzf
# NOTE: may not be necessary
echo "\e[34m===== Setting up fzf\e[0m"
PATH="$PATH:$HOME/.fzf/bin/fzf"
if [ ! $(command -v fzf) ]
then
  echo "\e[33mInstalling fzf\e[0m"
  git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
  $HOME/.fzf/install
  if [ $? ]
  then
    echo "\e[32mDone installing fzf\e[0m"
  else
    echo "\e[31mCRITICAL: failed to install fzf\e[0m"
    exit 1
  fi
fi



# finished
echo "export PATH=$PATH"
echo "\e[34m=======================================\e[0m"
