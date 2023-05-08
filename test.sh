#!/bin/sh

tux_test() {
  echo "=== summoning tux!"
  cowsay -f tux "Testing..."
  echo "=== finished summoning tux!"
  ok=0
}


oh_no() {
  echo "OH NO! Something Went wrong, do you want to try it manually?" 2>/dev/null
  read -r response
  case $response in
    Y | y | Yes | yes)
      sh
      ok=1
      ;;
    *)
      ok=0
      ;;
  esac
}



main() {
  echo "let's try this thing..."
  ok=0
  while [ "$ok" -ne "1" ]
  do
    eval tux_test
    if [ "$ok" -eq "1" ]
    then
      echo "no hitches, ending..."
      break
    else
      echo "encountered a problem, getting your help..."
      eval oh_no
      if [ "$ok" -eq "1" ]
      then
        echo "manual work finished, closing down..."
        continue
      else
        echo "manual work skipped, passing up..."
        break
      fi
    fi
  done
  echo "DONE"
}


eval main
