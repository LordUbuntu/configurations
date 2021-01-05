# setup script for python programming language
packages="
  neovim
  black
  flake8
  buku
"
[[ `command -v apt` ]] && pip="pip3" || pip="pip"

echo """
##### SETTING UP PYTHON #####"""
if [[ `command -v $pip` ]]
then
  echo "updating pip to latest version..."
  $pip install --upgrade pip
  if [[ $packages != "" ]]
  then
    echo "installing packages for python..."
    $pip install $packages
  fi
else
  echo """
##### SKIPPING PYTHON, PIP NOT INSTALLED #####
  """
fi
echo """##### DONE #####
"""
