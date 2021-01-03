# setup script for python programming language
packages="
  neovim
  black
  flake8
  buku
"

echo """

##### SETTING UP PYTHON #####"""
if [[ -f `which pip3` ]] || [[ -f `which pip` ]]
then
  echo "updating pip to latest version..."
  pip3 install --upgrade pip
  if [[ $packages != "" ]]
  then
    echo "installing packages for python..."
    pip3 install $packages
  fi
else
  echo """##### SKIPPING PYTHON, PIP NOT INSTALLED #####"""
fi
echo """##### DONE #####"""
