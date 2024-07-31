#!/bin/bash

source "$(dirname "$0")/../.base.sh"
set -e

echo
echo "${BOLD}Install Tidal electron client:$END"

aurs=(tidal-hifi-git)

# Proceed

echo "${GREEN}Installing...$END"

install_aur "${aurs[@]}"

echo 'Goodbye!'
echo

xdg-open 'https://github.com/Mastermindzh/tidal-hifi'
exit 0
