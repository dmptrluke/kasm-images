#!/bin/bash
set -e

declare -a fonts=(
  0xProto
  RobotoMono
)

version=$(curl -s 'https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest' | jq -r '.name')
if [ -z "$version" ] || [ "$version" = "null" ]; then
  echo "Warning: Could not fetch latest version, using fallback"
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

  if ! wget -q "$download_url"; then
    echo "Error: Failed to download $font, skipping..."
    continue
  fi

  if [ ! -f "$zip_file" ]; then
    echo "Error: Download succeeded but file $zip_file not found, skipping..."
    continue
  fi

  if ! unzip -o -q "$zip_file" -d "$fonts_dir"; then
    echo "Error: Failed to extract $zip_file, skipping..."
    rm -f "$zip_file"
    continue
  fi

  rm -f "$zip_file"
done

find "$fonts_dir" -name 'Windows Compatible' -delete

fc-cache -fv