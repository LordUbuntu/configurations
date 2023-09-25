#!/bin/sh
# This script will setup environment for all installed programs



echo """
#################
# BOOTSTRAPPING #
#################
"""



if [ ! $(command -v nix) ]
then
  # GENERAL LIST OF PROGRAMS TO INSTALL
  # see: nixos/configuration.nix for full list of packages on any system
  # note: to be general here, only essentials are listed/included. The rest should be covered manually or automated some other way
  #
  # DEV TOOLS
  # unzip
  # wget
  # curl
  # gzip
  # tar
  # bash
  # sh
  # git
  # gcc
  # clang
  # gnumake
  # python3 (with pip and pipx)
  # rustup
  # nano
  # neovim
  # distrobox (and podman)
  # docker
  # bat
  # bat-extras (batman, batgrep, batdiff)
  # delta
  # exa
  # fasd
  # fd
  # fzf
  # httpie
  # hyperfine
  # neofetch
  # nnn
  # ripgrep (and ripgrep-all)
  # starship
  # zellij
  # zsh
  # pandoc
  # texlive
  #
  # GUI APPS
  # discord
  # obsidian
  # spotify
  # amberol
  # anki
  # mpv
  

  programs="
  bash
  curl
  gcc
  git
  gzip
  sh
  tar
  unzip
  wget
  "

  if [ $(command -v apt) ]
  then
    # TODO: `install` function that will take in the string of packages, substitute any names where needed, and so on
    # substitute programs with weird names like bat -> bat-cat
    # install packages
    sudo apt install "$programs"
  elif [ $(command -v dnf) ]
  then
    sudo dnf install "$programs"
  elif [ $(command -v pacman) ]
  then
    sudo pacman -suy "$programs"
  fi
fi



# setup git if/once it is installed
if [ $(command -v git) ]
then
  if [ "$(git config user.email)" = "" ]
  then
    echo """
    ======= GIT =======
    """
    read -rp "Git user email: " email
    git config --global user.email "$email"
  fi
else
  echo "!!! GIT not installed !!!"
  exit 1
fi



if [ $(command -v ssh) ]
then
  if [ ! -f "$HOME/.ssh/id_rsa" ]
  then
    echo """
    ======= SSH =======
    """
    echo "Forging SSH keys for $USER with git email $(git config user.email)"
    ssh-keygen -t rsa -b 4096 -C "$(git config user.email)"
    ssh-add ~/.ssh/id_rsa
  fi
  if [ ! $(ps -p "$SSH_AGENT_PID" 2>/dev/null) ]
  then
    eval "$(ssh-agent -s)" &>/dev/null
  fi
else
  echo "!!! SSH not installed !!!"
  exit 1
fi



if [ $(command -v zsh) ]
then
  if [ $(basename "$SHELL") != zsh ]
  then
    echo """
    ======= ZSH =======
    """
    echo "Changing default shell of $USER to $(command -v zsh)"
    echo "sudo chsh -s \"$(command -v zsh)\" \"$USER\""
    sudo chsh -s "$(command -v zsh)" "$USER"
  fi
else
  echo "!!! ZSH not installed !!!"
  exit 1
fi
