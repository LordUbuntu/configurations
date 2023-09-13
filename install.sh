#!/bin/sh
# install program dependencies, setup environment, and copy dotfiles to system

# bootstrap general parts of the system
source general/functions.sh
sh general/bootstrap.sh

# for all programs
for program in $(ls dotfiles/.)
do
  # bootstrap program
  [ -e "dotfiles/$program/bootstrap.sh" ] && sh "dotfiles/$program/bootstrap.sh"
done
