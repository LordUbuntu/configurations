#!/bin/sh
# Jacobus Burger (2023)

# Install dependencies if not covered by nix
if [ ! $(command -v nix) ]
then
  sh deps.sh
fi



echo "\e[34m===== BOOTSTRAP ENVIRONMENT - NVIM\e[0m"
# install and setup neovim virtual environment
echo "\e[34m===== Setting up Python 3 virutual environment"
if [ ! -d "$HOME/.virtualenvs/neovim3" ]
then
  echo "\e[33mSetting up neovim3 virtual env\e[0m"
  # setup virutal environment path
  python -m venv "$HOME/.virtualenvs/neovim3"
  source "$HOME/.virtualenvs/neovim3/bin/activate"
  # install packages in virtual environment
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



echo "\e[34m=======================================\e[0m"
