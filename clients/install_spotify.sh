#!/bin/bash

source "$(dirname "$0")/../.base.sh"
set -e

echo
echo "${BOLD}Install Spotify official client:$END"

packages=(spotify-launcher)

# Proceed

echo "${GREEN}Installing...$END"

install "${packages[@]}"

echo 'Goodbye!'
echo

xdg-open 'https://wiki.archlinux.org/title/Spotify'
exit 0
