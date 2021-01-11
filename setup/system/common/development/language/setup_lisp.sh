#!/usr/bin/bash
# common lisp language setup script
packages=""

echo -e "\n##### SETTING UP COMMON LISP (SBCL) #####"
if [[ $(command -v sbcl) ]]
then
  if [[ ! -f $HOME/quicklisp/setup.lisp ]]
  then
    echo "sbcl installed, installing quicklisp..."
    curl -o /tmp/ql.lisp http://beta.quicklisp.org/quicklisp.lisp
    sbcl --no-sysinit --no-userinit --load /tmp/ql.lisp \
        --eval '(quicklisp-quickstart:install :path "~/.quicklisp")' \
        --eval '(ql:add-to-init-file)' \
        --quit
    rm /tmp/ql.lisp
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
