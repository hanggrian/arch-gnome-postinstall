#!/bin/bash

source "$(dirname "$0")/../.base.sh"
set -e

echo
echo "${BOLD}Install VLC official client:$END"

packages=(vlc)

# Proceed

echo "${GREEN}Installing...$END"

install "${packages[@]}"

echo 'Goodbye!'
echo

xdg-open 'https://wiki.archlinux.org/title/VLC_media_player'
exit 0
