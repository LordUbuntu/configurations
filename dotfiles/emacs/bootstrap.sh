#!/bin/sh
# Jacobus Burger (2023)

##### Install Dependencies if not on nix
if [ ! $(command -v nix) ]
then
  echo -e "\e[34m===== INSTALL DEPENDENCIES - EMACS\e[0m"
fi



##### Setup Environment



##### Link Files
source ../../install/functions.sh
link "$PWD/doom/." "$HOME/.doom.d"


echo -e "\e[34m=======================================\e[0m"
