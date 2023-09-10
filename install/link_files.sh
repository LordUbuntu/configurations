#!/bin/sh
# This script will link all dotfiles to the system

# change to dotfiles directory and loop through each program directory
cd ../dotfiles
for program in $(ls)
do
  # get the path of the link file for each program
  path="$PWD/$program/link"
  if [ -f "$path" ]
  then
    echo "link file for $program at $path"
    echo "  reads: $(cat $path)"
    # link each source=destination pair in the link file (absolue paths)
    while IFS="" read -r p || [ -n "$p" ]
    do
      src=$(cat $path | awk -F '=' '{print $1}')
      dst=$(cat $path | awk -F '=' '{print $2}')
      echo "from $src to $dst"
    done < "$path"
  fi
done
