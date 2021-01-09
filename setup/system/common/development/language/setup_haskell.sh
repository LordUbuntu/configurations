#!/usr/bin/bash
# haskell language setup script
packages="hlint"

echo -e "\n##### SETTING UP HASKELL #####"
if [[ $(command -v cabal) ]]
then
  echo "updating cabal to latest version..."
  cabal update
  cabal install cabal-install
  if [[ $packages != "" ]]
  then
    echo "installing packages for haskell..."
    cabal install $packages
  fi
else
  echo """
##### SKIPPING HASKELL, CABAL NOT INSTALLED #####
  """
fi
echo -e "##### DONE #####\n"
