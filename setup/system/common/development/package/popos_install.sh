#!/usr/bin/bash
# development install

echo """##### INSTALLING FOR UBUNTU BASED SYSTEM #####"""


# append packages that are not in common_packages
for package in ${development_packages[@]}
do
  if [[ ! `command -v $package` ]]
  then
    common_packages+=($package)
  fi
done


# install packages
pushd ../../distro >/dev/null
source popos_install.sh
popd >/dev/null
