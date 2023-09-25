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
  # 
  # FONTS
  # noto-sans
  # fira-code nerd font
  
  # install packages
  read -p "Do you want to install packages?" ans
  case $ans in
    [Yy]* )
        if [ $(command -v apt) ]
        then
          sudo apt install "$programs"
        elif [ $(command -v dnf) ]
        then
          # git-delta
          echo """===== Installing DNF PACKAGES"""   
          programs="unzip chsh wget curl gzip tar bash git gcc clang make cmake zsh neovim python3 python3-pip pipx distrobox podman docker-distribution docker-compose exa git-delta duf fd-find fzf httpie hyperfine neofetch nnn ripgrep pandoc texlive poppler ffmpeg mpv"
          sudo dnf install $programs
          echo """===== Installing MANUAL PACKAGES"""   
          # install spotify, amberol, obsidian, anki, discord
          flatpak install com.spotify.Client io.bassi.Amberol md.obsidian.Obsidian net.ankiweb.Anki com.discordapp.Discord io.github.celluloid_player.Celluloid
          # install ripgrep-all
          $HOME/.cargo/bin/cargo install --locked ripgrep_all
          # install wezterm
          sudo dnf install -y https://github.com/wez/wezterm/releases/download/nightly/wezterm-nightly-fedora38.rpm
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
