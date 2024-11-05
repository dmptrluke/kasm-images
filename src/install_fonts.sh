declare -a fonts=(
  0xProto
  DroidSansMono
  RobotoMono
  Ubuntu
  UbuntuMono
)

version=$(curl -s 'https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest' | jq -r '.name')
if [ -z "$version" ] || [ "$version" = "null" ]; then
  version="v3.2.1"
fi
fonts_dir="/usr/share/fonts"

if [[ ! -d "$fonts_dir" ]]; then
  mkdir -p "$fonts_dir"
fi

for font in "${fonts[@]}"; do
  zip_file="${font}.zip"
  download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/${version}/${zip_file}"
  echo "Downloading $download_url"
  wget "$download_url"
  unzip -o "$zip_file" -d "$fonts_dir"  # Added the -o option here to allow replacing
  rm "$zip_file"
done

find "$fonts_dir" -name 'Windows Compatible' -delete

fc-cache -fv