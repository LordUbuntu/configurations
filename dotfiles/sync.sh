#!/usr/bin/env bash
# exclude files by commenting them out
# XXX 
# - Really considering an alternative language for all these scripts or even the whole suite were bash not so ubiquitous...
# - The algorithms used herein suggest tuples, dicts, and zipWith among other
#   niceities that other better languages have spoiled me with...


# file programs
programs=(
  "zsh"
  "git"
  "alacritty"
  "nvim" # ignore the duplicates, bash makes them necessary
  "nvim"
  "sway"
  "zathura"
  "doom"
)
# file sources
source_files=(
  "zsh/zshrc"
  "git/gitconfig"
  "alacritty/alacritty.yml"
  "nvim/init.vim"
  "nvim/UltiSnips"
  "sway/config"
  "zathura/zathurarc"
  "emacs/doom"
)
# file destinations
destination_files=(
  "$HOME/.zshrc"
  "$HOME/.gitconfig"
  "$HOME/.config/alacritty/alacritty.yml"
  "$HOME/.config/nvim/init.vim"
  "$HOME/.config/nvim/UltiSnips"
  "$HOME/.config/sway/config"
  "$HOME/.config/zathura/zathurarc"
  "$HOME/.config/doom"
)


read -rp "are you sure, this will overwrite prexisting files [Y/n] " res
case $res in
  [Yy]) 
    ;;
  *)
    exit 1
    ;;
esac


echo """

##########################
# SYNCHRONIZING DOTFILES #
##########################

"""

# programs are the "key" in this sense
len=$(( ${#programs[@]} - 1 ))

# foreach program, source file, and destination file
for index in $(seq 0 $len)
do
  # abbreviate file names
  prog=${programs[$index]}
  src=${source_files[$index]}
  dest=${destination_files[$index]}

  # sync files if program installed
  if [[ $(command -v "$prog") ]]
  then
    # for a single file
    if [[ -f $src ]]
    then
      # create a directory if it does not exist
      if [[ ! -d $(dirname "$dest") ]]
      then
        echo "creating path '$(dirname "$dest")'"
        mkdir -p "$(dirname "$dest")"
      fi
      # remove prexisting file and link local to destination
      echo "removing prexisting file '$dest'..."
      rm "$dest"
      echo "linking '$src' => '$dest'..."
      ln "$src" "$dest"
    # for a directory
    elif [[ -d $src ]]
    then
      # create directory if it does not exist
      if [[ ! -d $dest ]]
      then
        echo "creating path '$dest'"
        mkdir -p "$dest"
      fi
      # remove prexisting files and link locals to destination
      echo "replacing contents of dir '$dest' with '$src'..."
      for file in $(ls "$dest")
      do
        echo -e "\tremoving prexisting file '$file'..."
        rm "$dest/$file"
      done
      for file in $(ls "$src")
      do
        echo -e "\tlinking '$file' => '$dest/$file'..."
        ln "$src/$file" "$dest/$file"
      done
    else
      # panic if the destination isn't a file or a directory (should be impossible)
      echo "BAD !! '$dest' isn't recognized as a file or directory that exists"
      exit 1
    fi
  else
    # skip syncing files if program not installed
    echo "program $prog not installed, not syncing files..."
  fi
done


echo """

########
# DONE #
########

"""
