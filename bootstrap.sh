#!/usr/bin/bash
# this file will bootstrap configurations for the current running system

common_packages=(
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
)
development_packages=(
  # tools
  zsh
  git
  ssh
  nvim
  emacs
  micro
  universal-ctags

  # languages
  python
  python-pip
  cabal-install
)
development_languages=(
  python
  haskell
)


# run setup for current system (includes common system setup)
pushd . >/dev/null
if [[ `command -v apt` ]]
then
  cd setup/system/popos
  source setup.sh
elif [[ `command -v yay` ]]
then
  cd setup/system/manjaro
  source setup.sh
elif [[ `command -v nix` ]]
then
  cd setup/system/nixos
  source setup.sh
fi
popd >/dev/null


# continue if not running nix
if [[ ! `command -v nix` ]]
then
  # run setup for development environment
  pushd setup/system/common/development >/dev/null
  source setup.sh
  popd >/dev/null

  # sync relevant dotfiles to system
  pushd dotfiles >/dev/null
  source sync.sh
  popd >/dev/null
else
  echo "skipping the rest, nix already has everything covered"
fi
