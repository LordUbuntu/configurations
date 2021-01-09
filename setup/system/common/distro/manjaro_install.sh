#!/usr/bin/bash
# common install for arch based systems
pkgs=""
for pkg in "${common_packages[@]}"
do
  # exceptions are listed in here
  case $pkg in
    hack-font)
      pkgs+=" " # dunno yet
      ;;
    *)
      pkgs+="$pkg "
      ;;
  esac
done

# install common packages
echo "packages collected, installing..."
echo "$pkgs"
yay -S $pkgs
