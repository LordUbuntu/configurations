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
shell="zsh fzf "
tools="git "
python="bpython "
haskell="cabal-install "



# UBUNTU BASED SETUP
if [[ -f `which apt` ]]
then
  # distro specific overrides
  shell+="fd-find bat silversearcher-ag"
  python+="python3 python3-pip"

  # native install packages
  sudo apt install $shell $tools \
      $python $haskell 'syncthing'

  # janky install packages
  #   hyperfine (tui benchmarking program)
  cd /tmp/
  wget https://github.com/sharkdp/hyperfine/releases/download/v1.11.0/hyperfine_1.11.0_amd64.deb
  sudo dpkg -i hyperfine_1.11.0_amd64.deb
  cd $HOME

  # remove undesirable packages
  sudo apt remove 'libreoffice-*'
  sudo apt autoremove
fi


# ARCH BASED SETUP
if [[ -f `which yay` ]]
then
  # distro specific overrides
  tools+="hyperfine "
  shell+="fd bat the_silver_searcher "
  python+="python python-pip "

  # native install packages
  yay -S $shell $tools \
      $python $haskell
fi
