#!/usr/bin/bash
# this file sets up the system (iff in [popos, manjaro, nixos])

# temporarily change directory and source script file
function source_dir {
  local path=$1
  local directory
  local file

  # handle errors
  if [[ ! -f $path ]]
  then
    # print err msg
    echo "ERR: could not find '$path'"
    echo "does it exist?"
    exit 1
  fi

  # get parts of file path
  directory=$(dirname "$path")
  file=$(basename "$path")

  # temporarily change to file and source it
  pushd "$directory" >/dev/null || exit
  source $file
  popd >/dev/null || exit
}



echo """

#################
# BOOTSTRAPPING #
#################

"""

# run setup for current system (includes common system setup)
if [[ ! $(command -v nix) ]]
then
  # setup imparative distro
  if [[ $(command -v apt) ]]
  then
    source_dir setup/system/popos/setup.sh
  elif [[ $(command -v yay) ]]
  then
    source_dir setup/system/manjaro/setup.sh
  fi

  # setup languages
  source_dir setup/dev/languages.sh

  # setup user environment
  source_dir setup/setup.sh

  # sync relevant dotfiles to system
  source_dir dotfiles/sync.sh
else
  echo "skipping, nix already has everything covered"
fi



echo """

########
# DONE #
########

"""
