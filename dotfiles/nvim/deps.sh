#!/bin/sh
# install dependencies for nvim

# TODO:
# - treesitter
#   - rust (cargo)
#   - tree-sitter-cli (`cargo install tree-sitter-cli`)
# - go build chain (darkman)

# install and setup pyenv to give neovim a Python 3 provider with virutalenv
if [ ! $(command -v curl) ]
then
  echo "CRITICAL: curl is missing"
  exit 1
else
  if [ -d "$HOME/.pyenv" ]
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
