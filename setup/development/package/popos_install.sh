#!/usr/bin/bash

echo """##### INSTALLING FOR UBUNTU BASED SYSTEM #####"""

# collect the correct packages for ubuntu-based systems and install them
pkgs=""
for pkg in ${packages[@]}
do
  # exceptions are listed in here
  case $pkg in
    fd)
      pkgs+="fd-find "
      ;;
    the_silver_searcher)
      pkgs+="silversearcher-ag "
      ;;
    python)
      pkgs+="python3 "
      ;;
    python-pip)
      pkgs+="python3-pip "
      ;;
    *)
      pkgs+="$pkg "
      ;;
  esac
done

# install packages
echo "packages collected, installing..."
echo $pkgs
sudo apt install $pkgs
