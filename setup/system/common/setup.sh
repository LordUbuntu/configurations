#!/usr/bin/bash
# this shell script sets up the most common packages used between all distros
# make sure to exclude nixos, since it does things rather differently. it may be included again in the future with home-manager but even then the setup would be deferred to /system/nixos instead of /common/setup
# this script should also call the system specific common installation script, which will install any packages common to all systems, for that particular system

# install common packages
source distro/install.sh


if [[ -f `which mpd` ]]
then
  echo "setting up mpd + ncmpcpp"
  [[ ! -d $HOME/.config/mpd ]] && mkdir ~/.config/mpd
  [[ ! -d $HOME/.local/share/mpd ]] && mkdir ~/.local/share/mpd
  [[ ! -d $HOME/.config/ncmpcpp ]] && mkdir ~/.config/ncmpcpp
  sudo service mpd restart
  sudo systemctl restart mpd.service
else
  echo "skipping mpd + ncmpcpp, not installed"
fi
# mpd # mpd is automatically set to autostart on user login
# you can check if it worked with `tail ~/.local/share/mpd/mpd.log`
