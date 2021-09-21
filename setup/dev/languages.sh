#!/usr/bin/bash
# installs development packages using language package manager(s)

echo """

########################
# SETTING UP LANGUAGES #
########################

"""

echo -e "\n##### INSTALLING PYTHON PACKAGES #####"
pip_pkgs="bpython black flake8 buku"
if [[ $(command -v pip) ]]
then
  pip install $pip_pkgs
  echo -e "\n##### PYTHON PACKAGES INSTALLED #####\n\n"
else
  echo -e "skipping python, pip not installed...\n\n"
fi



echo -e "\n##### INSTALLING HASKELL PACKAGES #####"
hask_pkgs="hlint hoogle"
if [[ $(command -v cabal) ]]
then
  cabal update
  cabal install cabal-install
  cabal install $hask_pkgs
  echo -e "\n##### HASKELL PACKAGES INSTALLED #####\n\n"
else
  echo -e "skipping haskell, cabal not installed...\n\n"
fi



echo -e "\n##### INSTALLING LISP PACKAGES #####"
lisp=""
if [[ $(command -v sbcl) ]]
then
  curl -o /tmp/ql.lisp http://beta.quicklisp.org/quicklisp.lisp
  sbcl --no-sysinit --no-userinit --load /tmp/ql.lisp \
       --eval '(quicklisp-quickstart:install :path "~/.quicklisp")' \
       --eval '(ql:add-to-init-file)' \
       --quit
  rm /tmp/ql.lisp
  echo -e "\n##### LISP PACKAGES INSTALLED #####\n\n"
else
  echo -e "skipping lisp, sbcl not installed...\n\n"
fi
