echo -e "\e[34m===== BOOTSTRAP - ZSH\e[0m"


##### Install Dependencies if not on nix
if [ ! $(command -v nix) ]
then
  # duf, exa, ripgrep, ripgrep-all, fzf, bat,
  # fd, python3, python3-pip, pipx, fasd, nnn,
  # starship, unimatrix
  echo -e "\e[34m===== INSTALL DEPENDENCIES - ZSH\e[0m"
  # install python3, python3-pip, pipx, and cargo
  if [ ! -f "$HOME/.cargo/bin/cargo" ]
  then
    echo -e "\e[34m===== INSTALL RUST\e[0m"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  fi
  if [ $(command -v dnf) ]
  then
    sudo dnf install python3 python3-pip pipx
  fi
  # install bat
  $HOME/.cargo/bin/cargo install bat
  # install bat-extras
  git clone https://github.com/eth-p/bat-extras.git
  cd bat-extras
  ./build.sh
  cd ..
  rm -rf bat-extras
  # install duf
  if [ $(command -v dnf) ]
  then
    sudo dnf install duf
  fi
  # install exa
  if [ ! $(command -v exa) ]
  then
    $HOME/.cargo/bin/cargo install exa
  fi
  # install fd-find
  if [ ! $(command -v fd) ]
  then
    $HOME/.cargo/bin/cargo install fd-find
  fi
  # install fzf
  if [ ! -f "$HOME/.fzf/install" ]
  then
    git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
    $HOME/.fzf/install
  fi
  # install fasd
  if [ ! -f "$HOME/.fasd" ]
  then
    git clone https://github.com/clvv/fasd
    cd fasd
    make install
    PREFIX=$HOME make install
    cd ..
    rm -rf fasd
  fi
  # install ripgrep and ripgrep-all
  if [ ! $(command -v rg) ]
  then
    $HOME/.cargo/bin/cargo install ripgrep
    $HOME/.cargo/bin/cargo install ripgrep_all
  fi
  # install starship
  if [ ! $(command -v starship) ]
  then
    $HOME/.cargo/bin/cargo install starship
  fi
  # install unimatrix
  if [ $(command -v pipx) ]
  then
    pipx install git+https://github.com/will8211/unimatrix.git
  fi
else
  echo "please ensure zsh dependencies are installed"
fi


##### Link Files
source general/functions.sh
link "$PWD/dotfiles/zsh/zshrc" "$HOME/.zshrc"


echo -e "\e[34m=======================================\e[0m"
