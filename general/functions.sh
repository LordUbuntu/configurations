function link {
  src=$1
  dst=$2
  echo "Linking $src to $dst"
  read -p "This will overwrite all files at $dst, continue?" ans
  case $ans in
    [Yy]* )
      echo "copying from $src to $dst"
      rm -rf "$dst"
      [ ! -d "$(dirname $dst)" ] && mkdir -p "$(dirname $dst)"
      [ -d "$src" ] && cp -R "$src"/. "$dst" || cp -R "$src" "$dst"
      break;;
  * ) echo "Skipping..."
  esac
}
