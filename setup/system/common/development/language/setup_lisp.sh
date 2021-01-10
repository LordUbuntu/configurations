#!/usr/bin/bash
# common lisp language setup script
packages=""

echo -e "\n##### SETTING UP COMMON LISP (SBCL) #####"
if [[ $(command -v sbcl) ]]
then
  if [[ ! -f $HOME/quicklisp/setup.lisp ]]
  then
    echo "sbcl installed, installing quicklisp..."
    pushd . >/dev/null || exit
    cd "$HOME" || exit
    curl -O https://beta.quicklisp.org/quicklisp.lisp quicklisp.lisp
    sbcl --load quicklisp.lisp \
        --eval "(quicklisp-quickstart:install)" \
        --eval "(ql:add-to-init-file)" \
        --eval "(quit)"
    rm quicklisp.lisp
    popd >/dev/null || exit
    echo "quicklisp installed for sbcl!"
  else
    echo "quicklisp already installed!"
  fi
  echo "Happy hacking!"
else
  echo "sbcl not installed, can't setup quicklisp!"
  echo -e "\n##### SKIPPING COMMON LISP, SBCL NOT INSTALLED #####"
fi
echo -e "##### DONE #####\n"
