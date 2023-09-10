#!/bin/sh
# Jacobus Burger (2023)
echo "\e[34m===== INSTALL DEPENDENCIES - NVIM\e[0m"



if [ ! $(command -v cargo) ]
then
  echo "\e[34m===== INSTALL RUST\e[0m"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
if [ ! $(command -v tree-sitter) ]
then
  echo "\e[34m===== INSTALL TREESITTER\e[0m"
  cargo install tree-sitter-cli
fi



echo "\e[34m=======================================\e[0m"
