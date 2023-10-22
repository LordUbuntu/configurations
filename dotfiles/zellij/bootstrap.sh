echo -e "\e[34m===== BOOTSTRAP - ZELLIJ\e[0m"



##### Install Dependencies if not on nix
if [ ! $(command -v nix) ]
then
  echo -e "\e[34m===== INSTALL DEPENDENCIES - ZELLIJ\e[0m"
  # install rust
  if [ ! -f "$HOME/.cargo/bin/cargo" ]
  then
    echo -e "\e[34m===== INSTALL RUST\e[0m"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  fi
  # install zellij
  if [ ! -f "$HOME/.cargo/bin/zellij" ]
  then
    echo -e "\e[34m===== INSTALL ZELLIJ\e[0m"
    $HOME/.cargo/bin/cargo install zellij
  fi
else
  echo "please ensure pkgs.bat-extras"
fi



##### Link Files
source general/functions.sh
link "$PWD/dotfiles/zellij/config.kdl" "$HOME/.config/zellij/config.kdl"


echo -e "\e[34m=======================================\e[0m"
