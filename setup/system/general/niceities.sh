#!/usr/bin/env bash
# lists fancy/colorful command line tools and other niceities

tools=(
  # exa
  # fd
  # sd
  # hyperfine
  # ripgrep
  # httpie
  # bat
  # mdp
  # asciiquarium
  zsh
  neovim
  fzf
  fasd
  alacritty
  nnn
  cmatrix
)
packages=""
len=$(( ${#tools[@]} - 1 ))

echo
echo "consider additionally installing: "
for index in $(seq 0 $len)
do
  tool=${tools[$index]}
  packages+="$tool "
  echo $tool
done

read -p "install niceities [Y/n] " ans
if [[ $ans == "Y" ]] || [[ $ans == "y" ]]
then
  sudo apt install $packages
fi
