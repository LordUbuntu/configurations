#!/usr/bin/env bash
# this script sets up the packages for my development environment on any system


###################
# DISTRO AGNOSTIC #
###################

# install fasd
cd /tmp/
git clone https://github.com/clvv/fasd.git
cd fasd
sudo make install
cd $HOME





#############################
# DISTRO SPECIFIC PROCEDURE #
#############################


# PACKAGES
tools="git "
shell="zsh fzf "
python="python3 python3-pip bpython "
haskell="cabal-install "
langs=$python$haskell


# UBUNTU BASED SETUP
if [[ -f `which apt` ]]
then
  # distro specific overrides
  shell+="fd-find bat silversearcher-ag"

  # native install packages
  sudo apt install $shell $python $haskell $tools

  # janky install packages
  #   hyperfine (tui benchmarking program)
  cd /tmp/
  wget https://github.com/sharkdp/hyperfine/releases/download/v1.11.0/hyperfine_1.11.0_amd64.deb
  sudo dpkg -i hyperfine_1.11.0_amd64.deb
  cd $HOME
fi


# ARCH BASED SETUP
if [[ -f `which yay` ]]
then
  # distro specific overrides
  tools+="hyperfine "
  shell+="fd bat the_silver_searcher "

  # native install packages
  yay -S $shell $langs $tools
fi
