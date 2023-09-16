echo -e "\e[34m===== BOOTSTRAP - WEZTERM\e[0m"



##### Install Dependencies if not on nix
if [ ! $(command -v nix) ]
then
  echo -e "\e[34m===== INSTALL DEPENDENCIES - BAT\e[0m"
else
  echo "please ensure fonts are installed..."
fi



##### Link Files
source general/functions.sh
link "$PWD/dotfiles/wezterm/wezterm.lua" "$HOME/.config/wezterm/wezterm.lua"


echo -e "\e[34m=======================================\e[0m"
