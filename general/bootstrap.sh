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
  
  # core  packages
  programs="unzip wget curl gzip tar bash git gcc clang make cmake neovim"


  # install packages
  read -p "Do you want to install packages?" ans
  case $ans in
    [Yy]* )
        if [ $(command -v apt) ]
        then
          # substitute packages
          # pip -> python3-pip
          # python -> python3
          sudo apt install "$programs"
        elif [ $(command -v dnf) ]
        then
          echo """===== Installing DNF PACKAGES"""   
          programs="unzip wget curl gzip tar bash git gcc clang make cmake neovim python3 python3-pip pipx distrobox podman docker-distribution docker-compose git-delta exa fd-find fzf httpie hyperfine neofetch nnn ripgrep zsh pandoc texlive discord mpv"
          sudo dnf install $programs
          echo """===== Installing MANUAL PACKAGES"""   
          # install spotify, amberol, obsidian, and anki with flatpak
          flatpak install com.spotify.Client io.bassi.Amberol md.obsidian.Obsidian net.ankiweb.Anki
          
          # NOTE: fasd must be installed manually, so must ripgrep-all, and starship, and zellij, and obsidian, and spotify, and amberol, and anki, rustup
        elif [ $(command -v pacman) ]
        then
          sudo pacman -suy "$programs"
        fi
      break;;
  * ) echo "Skipping..."
  esac
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
