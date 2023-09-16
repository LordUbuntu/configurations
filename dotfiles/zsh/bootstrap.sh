echo -e "\e[34m===== BOOTSTRAP - ZSH\e[0m"



##### Install Dependencies if not on nix
if [ ! $(command -v nix) ]
then
  echo -e "\e[34m===== INSTALL DEPENDENCIES - ZSH\e[0m"
else
  echo "please ensure duf, exa, ripgrep, ripgrep-all, zellij, nvim, cargo, fzf, fasd, nnn, starship, and unimatrix"
fi



##### Link Files
source general/functions.sh
link "$PWD/dotfiles/zsh/zshrc" "$HOME/.zshrc"


echo -e "\e[34m=======================================\e[0m"
