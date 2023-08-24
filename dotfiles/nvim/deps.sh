#!/bin/sh
# install dependencies for nvim
echo "========== INSTALLING - NVIM =========="



# ensure prerequisites met
if [ ! $(command -v curl) ]
then
  echo "CRITICAL: curl is missing"
  exit 1
fi



# install and setup treesitter
# install and setup rust build tools
if [ ! $(command -v cargo) ]
then
  echo "Installing rust"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
if [ ! $(command -v treesitter) ]
then
  echo "Installing treesitter"
  export PATH="$PATH:$HOME/.cargo/bin"
  cargo install tree-sitter-cli
fi



# install and setup pyenv to give neovim a Python 3 provider with virutalenv
if [ ! -d "$HOME/.pyenv" ]
then
  echo "Installing pyenv"
  PYENV_GIT_TAG=v2.3.24 
  curl https://pyenv.run | bash
fi
if [ -f "$HOME/.pyenv/bin/pyenv" ]
then
  echo "Setting up neovim pyenv"
  # put pyenv in path if it exists but isn't in it
  if [ ! $(command -v pyenv) ]
  then
    export PATH="$PATH:$HOME/.pyenv/bin/pyenv"
  fi
  # install and create virtualenv
  pyenv install 3.10
  pyenv virtualenv neovim3
  # install packages in virtual env
  echo "Setting up neovim3 virtual env"
  pyenv activate neovim3
  pip install pynvim neovim
  source deactivate
fi



# TODO:
# - go build chain (darkman)




# finished
echo "Set up dependencies for neovim, PATH=$PATH"
echo "===================="
