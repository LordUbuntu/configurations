#!/bin/sh
cd ../dotfiles
mv dot_config .config
mv dot_zshrc .zshrc
cp .zshrc $HOME/.zshrc
cp -R .config/* $HOME/.config/
mv .config dot_config
mv .zshrc dot_zshrc
