#!/usr/bin/bash
# setup script for python programming language
packages="
  neovim
  black
  flake8
  buku
"
[[ $(command -v apt) ]] && pip="pip3" || pip="pip"

echo -e "\n##### SETTING UP PYTHON #####"
if [[ $(command -v $pip) ]]
then
  echo "updating pip to latest version..."
  $pip install --upgrade pip
  if [[ $packages != "" ]]
  then
    echo "installing packages for python..."
    $pip install $packages
  fi
else
  echo -e "\n##### SKIPPING PYTHON, PIP NOT INSTALLED #####\n"
fi
echo -e "##### DONE #####\n"
