#!/bin/sh
# Jacobus Burger (2023)
echo -e "\e[34m===== BOOTSTRAP - STARSHIP\e[0m"



##### Install Dependencies if not on nix
if [ ! $(command -v nix) ]
then
  # ensure rustup
  if [ ! $(command -v cargo) ]
  then
    echo -e "\e[34m===== INSTALL RUST\e[0m"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  fi
  # install starship itself
  if [ ! $(command -v starship) ]
  then
    echo -e "\e[34m===== INSTALL STARSHIP\e[0m"
    cargo install starship
  fi
fi



##### Link Files
source general/functions.sh
link "$PWD/dotfiles/starship/starship.toml" "$HOME/.config/starship/starship.toml"

echo -e "\e[34m=======================================\e[0m"
