#!/bin/sh
# This script will link all dotfiles to the system

# change to dotfiles directory and loop through each program directory
cd ../dotfiles
DOT_DIR="$PWD"
for program in $(ls)
do
  # get the path of the link file for each program
  path="$DOT_DIR/$program/link"
  if [ -f "$path" ]
  then
    echo "link file for $program at $path"
    cd "$(dirname $path)"
    # link each source=destination pair in the link file (absolue paths)
    while IFS="" read -r p || [ -n "$p" ]
    do
      src=$(cat "$PWD/link" | awk -F '=' '{print $1}')
      dst=$(cat "$PWD/link" | awk -F '=' '{print $2}')
      # FIXME:
      echo -e "  cp -s $(eval $src) $(eval $dst)" 
      # cp -s "$src" "$dst"
    done < "$PWD/link"
    cd "$DOT_DIR"
  fi
done
