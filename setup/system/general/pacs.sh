#!/usr/bin/env bash
# install packages that I tend to use between systems

packages="""
  fzf
  fasd
  hyperfine
  alacritty
"""

sudo apt install $packages
