#!/bin/sh
# This script will link all dotfiles to the system
for program in $(ls ../dotfiles)
do
  for file in $(ls ../dotfiles/$program)
  do
    path="../dotfiles/$program/$file"
    if [ "$file" = "link" ]
    then
      echo "link file for $program at $path"
      echo "  reads: $(cat $path)"
    else
      echo "no link file for $program, skipping..."
    fi
  done
done
