function link {
  src=$1
  dst=$2
  echo -e "\e[34m===== Linking $src to $dst\e[0m"
  read -p "This will overwrite all files at $(dirname $dst), continue?" ans
  case $ans in
    [Yy]* )
      echo "copying from $PWD/default to $dst"
      rm -rf "$dst"
      cp -R "$PWD/default/." "$dst"
      break;;
  * ) echo "Skipping..."
  esac
}

export -f link
