#!/bin/sh
# Jacobus Burger (2023)
echo -e "\e[34m===== BOOTSTRAP - GIT\e[0m"



##### Install Dependencies
if [ ! $(command -v nix) ]
then
  # install delta for diff highlighting
  if [ ! -f "$HOME/.cargo/bin/cargo" ]
  then
    echo -e "\e[34m===== INSTALL RUST\e[0m"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  fi
  # install delta for batdiff
  if [ ! $(command -v delta) ]
  then
    $HOME/.cargo/bin/cargo install git-delta
  else
    echo "can't install delta, cargo not installed..."
  fi
fi


##### Link Files
source general/functions.sh
link "$PWD/dotfiles/git/gitconfig" "$HOME/.gitconfig"

echo -e "\e[34m=======================================\e[0m"
