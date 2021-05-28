#!/usr/bin/bash
# this file will bootstrap configurations for the current running system




########################
# FUNCTION DEFINITIONS #
########################

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












#######################
# PACKAGE DEFINITIONS #
#######################

# common user packages
export common_packages=(
  mpv
  cmus # better than mpd for my usecase
  picard # musicbrainz music tagging
  ffmpeg
  youtube-dl
  zathura*
  # mpd
  # mpc
  # ncmpcpp
  hack-font # fonts-hack for ubuntu, (nerd fonts for most else?)
  alacritty
  httpie
  exa
  bcal
  nnn
  cmatrix
  fd                    # fd-find on ubuntu-based systems
  bat
  the_silver_searcher
  ripgrep
  fzf
  fasd
  hyperfine             # must be done manually for ubuntu
  syncthing             # will be brig in the future
  bpython
  # ssh       # openssh server
  # endlessh  # torture hackers who try to bruteforce into my servers with ssh
  pandoc
  texlive
    texlive-xetex
    texlive-puglishers
    texlive-latex-extra
    texlive-lang-*
    texlive-fonts-*

)
# common development packages
export development_packages=(
  # tools
  zsh
  git
  gitsome  # simply great github integration
  ssh
  universal-ctags
  ccls
  shellcheck

  # editors
  neovim
  emacs
  micro

  # languages
  python
  python-pip
  cabal-install
  sbcl
  gcc
  g++
)
# language configs
export development_languages=(
  python
  haskell
  lisp
)


# run setup for current system (includes common system setup)
if [[ $(command -v apt) ]]
then
  source_dir setup/system/popos/setup.sh
elif [[ $(command -v yay) ]]
then
  source_dir setup/system/manjaro/setup.sh
elif [[ $(command -v nix) ]]
then
  source_dir setup/system/manjaro/setup.sh
fi


# continue if not running nix
if [[ ! $(command -v nix) ]]
then
  # run setup for development environment
  source_dir setup/system/common/development/setup.sh

  # sync relevant dotfiles to system
  source_dir dotfiles/sync.sh
else
  echo "skipping the rest, nix already has everything covered"
fi
