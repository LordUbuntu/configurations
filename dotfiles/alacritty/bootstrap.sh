#!/bin/sh
# Jacobus Burger (2023)
echo -e "\e[34m===== BOOTSTRAP - BTOP\e[0m"

##### Link Files
source general/functions.sh
link "$PWD/dotfiles/starship/starship.toml" "$HOME/.config/starship/starship.toml"

echo -e "\e[34m=======================================\e[0m"
