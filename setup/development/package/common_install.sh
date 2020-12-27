#!/usr/bin/env bash
# this script installs common packages for my development environment


###################
# DISTRO AGNOSTIC #
###################

echo """

################################################
# MANUALLY INSTALLING DISTRO AGNOSTIC PROGRAMS #
################################################

"""


# install fasd
if [[ ! -f `which fasd` ]]
then
  echo """

##### INSTALLING FASD SHELL UTILITY #####"""
  pushd . > /dev/null
  cd /tmp/
  git clone https://github.com/clvv/fasd.git
  cd fasd
  sudo make install 
  popd > /dev/null
  echo """##### DONE #####"""
else
  echo """##### FASD ALREADY INSTALLED #####"""
fi


# install fzf
if [[ ! -f `which fzf` ]]
then
  echo """

##### INSTALLING FZF SHELL UTILITY #####"""
  pushd . > /dev/null
  cd $HOME
  git clone --depth 1 https://github.com/junegunn/fzf.git
  yes | $HOME/.fzf/install
  popd > /dev/null
  echo """##### DONE #####"""
else
  echo """##### FZF ALREADY INSTALLED #####"""
fi

# install hyperfine for ubuntu
if [[ ! -f `which hyperfine` ]] && [[ -f `which apt` ]]
then
  echo """

##### INSTALLING HYPERFINE SHELL UTILITY #####"""
  pushd . > /dev/null
  cd /tmp/
  wget -q https://github.com/sharkdp/hyperfine/releases/download/v1.11.0/hyperfine_1.11.0_amd64.deb
  sudo dpkg -i hyperfine_1.11.0_amd64.deb > /dev/null
  popd > /dev/null
  echo """##### DONE #####"""
else
  echo """##### FASD ALREADY INSTALLED #####"""
fi





#############################
# DISTRO SPECIFIC PROCEDURE #
#############################

echo """

#######################################
# INSTALLING DISTRO SPECIFIC PACKAGES #
#######################################

"""


packages=(
  # shell
  zsh
  fd                    # fd-find on ubuntu-based systems
  bat
  the_silver_searcher   # silversearcher-ag on ubuntu-based systems
  ripgrep

  # tools
  git
  neovim
  emacs
  universal-ctags
  hyperfine             # must be done manually for ubuntu
  syncthing             # will be brig in the future

  # languages
    # python
  python                # python3 on ubuntu-based systems
  python-pip            # python3-pip on ubuntu-based systems
  bpython
    # haskell
  cabal-install
)


if [[ -f `which apt` ]]
then
  source package/popos_install.sh
elif [[ -f `which yay` ]]
then
  source package/manjaro_install.sh
fi
