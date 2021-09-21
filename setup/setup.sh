#!/usr/bin/bash
# configures user environment for programs

echo """

####################
# SETTING UP TOOLS #
####################

"""


# setup zsh as default shell
if [[ $(command -v zsh) ]]
then
  echo -e "\n##### SETTING UP ZSH #####"
  if [[ $(basename "$SHELL") != zsh ]]
  then
    echo "changing default shell for $(whoami) to zsh..."
    sudo chsh -s "$(command -v zsh)" "$(whoami)"
    echo "set default shell for $(whoami) to $(command -v zsh), ret code: $?"
  else
    echo "zsh already set as default shell!"
  fi
  echo -e "##### DONE #####\n"
else
  echo -e "\n##### SKIPPING ZSH, NOT INSTALLED #####\n"
fi


# setup git for current user
if [[ $(command -v git) ]]
then
  echo -e "\n##### SETTING UP GIT #####"
  if [[ $(git config user.email) == "" ]]
  then
    read -rp "set git user email: " email
    echo "setting git user email..."
    git config --global user.email "$email"
    echo "set user email for git to $(git config user.email), ret code: $?"
  else
    echo "user email already set for git!"
  fi
  echo -e "##### DONE #####\n"
else
  echo -e "\n##### SKIPPING GIT, NOT INSTALLED #####\n"
fi


# setup ssh for git
if [[ $(command -v ssh) ]]
then
  echo -e "\n##### SETTING UP SSH #####"
  # set up keys if not yet forged
  if [[ ! -f "$HOME/.ssh/id_rsa" ]]
  then
    echo "forging ssh rsa keys for git user..."
    ssh-keygen -t rsa -b 4096 -C "$email"
    ssh-add ~/.ssh/id_rsa
    echo "forged ssh keys, ret code: $?"
  else
    echo "ssh rsa keys already forged for git user!"
  fi
  # start an ssh agent if one doesn't already exist
  if [[ $(ps -p "$SSH_AGENT_PID" >/dev/null) ]]
  then
    echo "starting an ssh agent..."
    eval "$(ssh-agent -s)"
    echo "ssh agent started, ret code: $?"
  else
    echo "ssh agent already started!"
  fi
  # finish
  echo -e "##### DONE #####\n"
else
  echo -e "\n##### SKIPPING SSH, NOT INSTALLED #####\n"
fi


# install doom on system if emacs is installed and doom is not in path
if [[ $(command -v emacs) ]]
then
  echo -e "\n##### SETTING UP DOOM (EMACS) #####"
  if [[ ! $(command -v doom) ]]
  then
    echo "installing doom for emacs..."
    git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
    doom install
    echo "doom installed for emacs, ret code: $?"
  else
    echo "doom already installed for emacs!"
  fi
  echo -e "##### DONE #####\n"
else
  echo -e "\n##### SKIPPING DOOM, EMACS NOT INSTALLED #####"
fi
