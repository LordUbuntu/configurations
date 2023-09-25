#!/bin/sh
# Jacobus Burger (2023)
echo -e "\e[34m===== BOOTSTRAP - NVIM\e[0m"



##### Install Dependencies if not on nix
if [ ! $(command -v nix) ]
then
  echo -e "\e[34m===== INSTALL DEPENDENCIES - NVIM\e[0m"
  if [ ! -f "$HOME/.cargo/bin/cargo" ]
  then
    echo -e "\e[34m===== INSTALL RUST\e[0m"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  fi
  if [ ! $(command -v tree-sitter) ]
  then
    echo -e "\e[34m===== INSTALL TREESITTER\e[0m"
    $HOME/.cargo/bin/cargo install tree-sitter-cli
  fi
fi



##### Setup Environment
echo -e "\e[34m===== BOOTSTRAP ENVIRONMENT - NVIM\e[0m"
if [ ! -d "$HOME/.virtualenvs/neovim3" ]
then
  # install and setup neovim virtual environment
  echo -e "\e[34m===== Setting up Python 3 virutual environment"
  # setup virutal environment path
  python -m venv "$HOME/.virtualenvs/neovim3"
  source "$HOME/.virtualenvs/neovim3/bin/activate"
  # install packages in virtual environment
  pip install pynvim neovim
  deactivate
  if [ $? ]
  then
    echo -e "\e[32mDone virtualenv for neovim\e[0m"
  else
    echo -e "\e[31mCRITICAL: failed to setup virutalenv for neovim\e[0m"
    exit 1
  fi
fi



# install and setup fzf
if [ ! $(command -v fzf) ]
then
  echo -e "\e[34m===== Setting up fzf\e[0m"
  git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
  $HOME/.fzf/install
  if [ $? ]
  then
    echo -e "\e[32mDone installing fzf\e[0m"
  else
    echo -e "\e[31mCRITICAL: failed to install fzf\e[0m"
    exit 1
  fi
fi



##### Link Files
source general/functions.sh
link "$PWD/dotfiles/nvim/default" "$HOME/.config/nvim"


echo -e "\e[34m=======================================\e[0m"
