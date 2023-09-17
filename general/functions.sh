function link {
  src=$1
  dst=$2
  echo "Linking $src to $dst"
  # 1. backup preexising files
  # 2. make program directory if it doesn't exist
  # 3. copy $src directory or $src file to $dst
  [ -e "$dst" ] && cp "$dst" "$dst.bak"  # backup preexisting files
  [ ! -d "$(dirname $dst)" ] && mkdir -p "$(dirname $dst)"
  [ -d "$src" ] && cp -R "$src"/. "$dst" || cp -R "$src" "$dst"
}
