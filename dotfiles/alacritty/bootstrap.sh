#!/bin/sh
# Jacobus Burger (2023)
echo -e "\e[34m===== BOOTSTRAP - ALACRITTY\e[0m"

##### Link Files
source general/functions.sh
link "$PWD/dotfiles/alacritty/alacritty.yml" "$HOME/.config/alacritty/alacritty.yml"

echo -e "\e[34m=======================================\e[0m"
