#!/usr/bin/env bash
# install packages required for environment


#############################
# DISTRO AGNOSTIC PROCEDURE #
#############################

# install fasd
cd /tmp/
git clone https://github.com/clvv/fasd.git
cd fasd
sudo make install
cd $HOME

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
yes | ~/.fzf/install

# install hyperfine
cd /tmp/
wget https://github.com/sharkdp/hyperfine/releases/download/v1.10.0/hyperfine_1.10.0_amd64.deb
sudo dpkg -i hyperfine_1.10.0_amd64.deb





#############################
# DISTRO SPECIFIC PROCEDURE #
#############################

# UBUNTU BASED
if [[ -f `which apt` ]]
then
  # install packages
  zsh_paks="zsh fd-find bat silversearcher-ag"
  dev_paks="python3 python3-pip cabal-install git"
  sudo apt install $zsh_paks $dev_paks

  # setup
  ln -s /usr/bin/fdfind $HOME/.local/bin/fd
  ln -s /usr/bin/batcat $HOME/.local/bin/bat
fi

# ARCH BASED
if [[ -f `which yay` ]]
then
  # TODO check this works on manjaro
  # install packages
  zsh_paks="zsh fd bat the_silver_searcher"
  dev_paks="python3 python3-pip cabal-install git"
  yay -S $zsh_paks $dev_paks
fi
