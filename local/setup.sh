#!/bin/sh
# Jacobus Burger (2023)
echo -e "\e[34m===== SETUP - DESKTOP FILES\e[0m"

##### Link Files
source general/functions.sh
for application in `ls $PWD/local/applications/`
do
  link "$PWD/local/applications/$application" "$HOME/.local/share/applications/$application"
done

echo -e "\e[34m=======================================\e[0m"
