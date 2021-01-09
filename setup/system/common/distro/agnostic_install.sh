#!/usr/bin/bash
# agnostic program installation

# install fasd
if [[ ! $(command -v fasd) ]]
then
  echo """##### INSTALLING FASD #####"""
  pushd /tmp/ >/dev/null || exit 
  git clone https://github.com/clvv/fasd.git
  cd fasd || exit
  sudo make install 
  popd >/dev/null || exit
  echo """##### DONE #####"""
else
  echo """##### FASD ALREADY INSTALLED #####"""
fi


# install fzf
if [[ ! $(command -v fzf) ]]
then
  echo """##### INSTALLING FZF #####"""
  pushd "$HOME" >/dev/null || exit
  git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
  yes | "$HOME/.fzf/install"
  popd >/dev/null || exit
  echo """##### DONE #####"""
else
  echo """##### FZF ALREADY INSTALLED #####"""
fi


# install hyperfine for ubuntu
if [[ ! $(command -v hyperfine) ]] && [[ $(command -v apt) ]]
then
  echo """##### INSTALLING HYPERFINE #####"""
  pushd /tmp/ >/dev/null || exit
  wget -q https://github.com/sharkdp/hyperfine/releases/download/v1.11.0/hyperfine_1.11.0_amd64.deb
  sudo dpkg -i hyperfine_1.11.0_amd64.deb >/dev/null
  popd >/dev/null || exit
  echo """##### DONE #####"""
else
  echo """##### HYPERFINE ALREADY INSTALLED #####"""
fi


# install sd for ubuntu
# not an option currently because of fasd
# if [[ ! $(command -v sd) ]]
# then
  # echo """##### INSTALLING SD #####"""
  # pushd /tmp/ >/dev/null || exit
  # wget -q https://github.com/chmln/sd/releases/download/v0.7.6/sd-v0.7.6-x86_64-unknown-linux-gnu > sd
  # cp sd $HOME/.local/bin/sd || exit
  # popd >/dev/null || exit
  # echo """##### DONE #####"""
# else
  # echo """##### SD ALREADY INSTALLED #####"""
# fi
