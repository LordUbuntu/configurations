# this shell script sets up the most common packages used between all distros
# make sure to exclude nixos, since it does things rather differently. it may be included again in the future with home-manager but even then the setup would be deferred to /system/nixos instead of /common/setup
# this script should also call the system specific common installation script, which will install any packages common to all systems, for that particular system


###################
# DISTRO SPECIFIC #
###################
# pushd .
# if [[ -f `which apt` ]]
# then
  # cd ../../system/popos/
  # ./common_install.sh
# elif [[ -f `which yay` ]]
# then
  # cd ../../system/manjaro/
  # ./common_install.sh
# # nixos doesn't currently need or have such a thing as an install script.
# # elif [[ -f `which nix` ]]
# # then
  # # cd ../../system/nixos/
  # # ...
# fi
# popd
