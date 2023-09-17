#!/bin/sh
# install program dependencies, setup environment, and copy dotfiles to system

# bootstrap general parts of the system
source general/functions.sh
sh general/bootstrap.sh

# setup path
export PATH="$PATH:/home/jaybee/.local/bin:/home/jaybee/bin:/home/jaybee/.cargo/bin"

# setup desktop files
read -p "Do you want to copy in desktop files?" ans
case $ans in
  [Yy]* )
    sh local/setup.sh
    break;;
* ) echo "Skipping..."
esac


# bootstrap dotfiles
read -p "Do you want to copy in dotfiles?" ans
case $ans in
  [Yy]* )
    for program in `ls dotfiles/.`
    do
      [ -e "dotfiles/$program/bootstrap.sh" ] && sh "dotfiles/$program/bootstrap.sh"
    done
    break;;
  * ) echo "Skipping..."
esac
