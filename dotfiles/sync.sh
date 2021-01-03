#!/usr/bin/env bash
# exclude files by commenting them out
# possibly replace this with a python script instead, since the datatypes
#   are far better




# file sources
source_files=(
  zsh/zshrc
  git/gitconfig
  alacritty/alacritty.yml
  nvim/init.vim
  nvim/UltiSnips
  sway/config
  mpd/mpd.conf
  ncmpcpp/config
  ncmpcpp/bindings
)
# file destinations
destination_files=(
  $HOME/.zshrc
  $HOME/.gitconfig
  $HOME/.config/alacritty/alacritty.yml
  $HOME/.config/nvim/init.vim
  $HOME/.config/nvim/UltiSnips
  $HOME/.config/sway/config
  $HOME/.config/mpd/mpd.conf
  $HOME/.config/ncmpcpp/config
  $HOME/.config/ncmpcpp/bindings
)

read -p "are you sure, this will overwrite prexisting files [Y/n] " res
case $res in
  [Yy]) continue;;
  *)    exit 1;;
esac

echo """

##########################
# SYNCHRONIZING DOTFILES #
##########################

"""

# length of destination_files array
len=$(( ${#destination_files[@]} - 1 ))

# link configs from src to dest
for index in $(seq 0 $len)
do
  # abbreviate file names
  src=${source_files[$index]}
  dest=${destination_files[$index]}

  # for a single file
  if [[ -f $src ]]
  then
    if [[ ! -d $(dirname $dest) ]]
    then
      echo "creating path '$(dirname $dest)'"
      mkdir -p $(dirname $dest)
    fi
    echo "removing prexisting file '$dest'..."
    rm $dest
    echo "linking '$src' => '$dest'..."
    ln $src $dest
  # for a directory
  elif [[ -d $src ]]
  then
    if [[ ! -d $dest ]]
    then
      echo "creating path '$dest'"
      mkdir -p $dest
    fi
    echo "replacing contents of dir '$dest' with '$src'..."
    for file in `ls $dest`
    do
      echo -e "\tremoving prexisting file '$file'..."
      rm $dest/$file
    done
    for file in `ls $src`
    do
      echo -e "\tlinking '$file' => '$dest/$file'..."
      ln $src/$file $dest/$file
    done
  else
    echo "BAD !! '$dest' isn't recognized as a file or directory that exists"
    exit 1
  fi
done

echo """

########
# DONE #
########

"""
