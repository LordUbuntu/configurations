#!/usr/bin/bash
# common install for ubuntu based systems
pkgs=""
for pkg in ${packages[@]}
do
  # exceptions are listed in here
  case $pkg in
    *)
      pkgs+="$pkg "
      ;;
  esac
done

# install packages
echo "packages collected, installing..."
echo $pkgs
sudo apt install $pkgs
