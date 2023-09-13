#!/bin/sh
# Jacobus Burger (2023)

##### Install Dependencies if not on nix
if [ ! $(command -v nix) ]
then
  echo -e "\e[34m===== INSTALL DEPENDENCIES - STARSHIP\e[0m"
fi



##### Setup Environment



##### Link Files
source general/functions.sh
link "$PWD/dotfiles/starship/starship.toml" "$HOME/.config/starship/starship.toml"

echo -e "\e[34m=======================================\e[0m"
