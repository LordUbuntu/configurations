#!/bin/sh
# Jacobus Burger (2023)
echo -e "\e[34m===== BOOTSTRAP - BTOP\e[0m"



##### Install Dependencies
if [ ! $(command -v btop) ]
then
  echo "PLEASE INSTALL BTOP"
fi



##### Link Files
source general/functions.sh
link "$PWD/dotfiles/btop/btop.conf" "$HOME/.config/btop/btop.conf"

echo -e "\e[34m=======================================\e[0m"
