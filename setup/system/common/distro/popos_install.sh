#!/usr/bin/bash
# common install for ubuntu based systems

# collect the correct packages for ubuntu-based systems and install them
pkgs=""
for pkg in ${common_packages[@]}
do
  # substitute names for certain packages
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
    hack-font)
      pkgs+="fonts-hack "
      ;;
    *)
      pkgs+="$pkg "
      ;;
  esac
done

# install common packages
echo """packages collected, installing..."""
echo $pkgs
sudo apt install $pkgs
