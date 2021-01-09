#!/usr/bin/bash
# this file will bootstrap configurations for the current running system




# function definitions

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














# package definitions
export common_packages=(
  mpv
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
  the_silver_searcher   # silversearcher-ag on ubuntu-based systems
  ripgrep
  fzf
  fasd
  hyperfine             # must be done manually for ubuntu
  syncthing             # will be brig in the future
  bpython
  # ssh       # openssh server
  # endlessh  # torture hackers who try to bruteforce into my servers with ssh
  pandoc
  # texlive # figure out latex packages
)
export development_packages=(
  # tools
  zsh
  git
  ssh
  neovim
  emacs
    # shellcheck
    # sbcl # consider getting a lisp setup running
  micro
  universal-ctags

  # languages
  python
  python-pip
  cabal-install
)
export development_languages=(
  # shell # todo
  # clang # todo
  # lisp # common lisp # todo
  python
  haskell
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
