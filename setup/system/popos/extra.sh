#!/bin/bash



# install minecraft
echo """
########################
# INSTALLING MINECRAFT #
########################

"""

pushd /tmp/ || exit
wget https://launcher.mojang.com/download/Minecraft.deb Minecraft.deb
sudo apt install gdebi-core
sudo gdebi Minecraft.deb
popd

echo """
MAKE SURE TO INSTALL THE FOLLOWING BY HAND:
- Bitwig Studio

~~~ Thank You ~~~
"""
