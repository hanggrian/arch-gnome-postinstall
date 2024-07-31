#!/bin/bash

source "$(dirname "$0")/../.base.sh"
set -e

echo
echo "${BOLD}Install Jellyfin official server:$END"

packages=(jellyfin-server jellyfin-web)

# Proceed

echo "${GREEN}Installing...$END"

install "${packages[@]}"

echo 'Goodbye!'
echo

xdg-open 'https://wiki.archlinux.org/title/Jellyfin'
exit 0
