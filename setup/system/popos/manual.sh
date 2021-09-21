#!/usr/bin/bash
# installs certain packages manually for the given distro

echo -e "\n##### MANUALLY INSTALLING PACKAGES #####\n\n"

# install fasd
if [[ ! $(command -v fasd) ]]
then
  echo -e "installing fasd...\n"
  pushd /tmp/ >/dev/null || exit 
  git clone https://github.com/clvv/fasd.git
  cd fasd || exit
  sudo make install 
  popd >/dev/null || exit
  echo -e "fasd installed manually...\n"
else
  echo -e "fasd already installed, skipping...\n"
fi



# install fzf
if [[ ! $(command -v fzf) ]]
then
  echo -e "installing fasd...\n"
  pushd "$HOME" >/dev/null || exit
  git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
  yes | "$HOME/.fzf/install"
  popd >/dev/null || exit
  echo -e "fasd installed manually...\n"
else
  echo -e "fasd already installed, skipping...\n"
fi



# install hyperfine
if [[ ! $(command -v hyperfine) ]]
then
  echo -e "installing hyperfine...\n"
  pushd /tmp/ >/dev/null || exit
  wget -q https://github.com/sharkdp/hyperfine/releases/download/v1.11.0/hyperfine_1.11.0_amd64.deb
  sudo dpkg -i hyperfine_1.11.0_amd64.deb >/dev/null
  popd >/dev/null || exit
  echo -e "hyperfine installed manually...\n"
else
  echo -e "hyperfine already installed, skipping...\n"
fi
