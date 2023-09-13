echo -e "\e[34m===== BOOTSTRAP - BAT\e[0m"



##### Install Dependencies if not on nix
if [ ! $(command -v nix) ]
then
  echo -e "\e[34m===== INSTALL DEPENDENCIES - BAT\e[0m"
  # install rust
  if [ ! $(command -v cargo) ]
  then
    echo -e "\e[34m===== INSTALL RUST\e[0m"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  fi
  # insall ripgrep for batgrep
  if [ ! $(command -v rg) ]
  then
    cargo install ripgrep
  fi
  # skip man and less because they're assumed to be present
  # install delta for batdiff
  if [ ! $(command -v delta) ]
  then
    cargo install git-delta
  else
    echo "can't install delta, cargo not installed..."
  fi

  # install bat-extras
  # see: https://github.com/eth-p/bat-extras
  if [ ! $(command -v batgrep) ]
  then
    cd /tmp/
    git clone https://github.com/eth-p/bat-extras.git
    cd bat-extras
    ./build.sh
  fi
else
  echo "please ensure pkgs.bat-extras"
fi



##### Link Files
source general/functions.sh
link "$PWD/dotfiles/bat/config" "$HOME/.config/bat/config"


echo -e "\e[34m=======================================\e[0m"
