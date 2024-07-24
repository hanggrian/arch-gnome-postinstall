#!/bin/bash

source "$(dirname "$0")/.base.sh"
set -e

echo
echo "${BOLD}Install GNOME extra apps and themes:$END"

packages=(gnome-extra)

# GVfs

echo "${YELLOW}Apply GVfs? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  packages+=(gvfs-goa)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

# fwupd

echo "${YELLOW}Apply fwupd? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  packages+=(fwupd)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

# Adwaita-dark

echo "${YELLOW}Apply Adwaita-dark? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  packages+=(gnome-themes-extra)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

# WebP Pixbuf Loader

echo "${YELLOW}Apply WebP Pixbuf Loader? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  packages+=(webp-pixbuf-loader)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

# Power Profiles Daemon

echo "${YELLOW}Apply Power Profiles Daemon? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  packages+=(power-profiles-daemon)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

# GST Plugin PipeWire

echo "${YELLOW}Apply GST Plugin PipeWire? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  packages+=(gst-plugin-pipewire)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

# Proceed

echo "${GREEN}Installing...$END"
install ${packages[@]}

xdg-open 'https://wiki.archlinux.org/title/GNOME'

echo 'Goodbye!'
echo
exit 0
