#!/bin/bash

source "$(dirname "$0")/../.base.sh"
set -e

echo
echo "${BOLD}Install Jellyfin official client:$END"

aurs=(jellyfin-media-player)

# Proceed

echo "${GREEN}Installing...$END"

install_aur "${aurs[@]}"

echo 'Goodbye!'
echo

xdg-open 'https://wiki.archlinux.org/title/Jellyfin'
exit 0
