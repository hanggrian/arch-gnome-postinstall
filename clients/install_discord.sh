#!/bin/bash

source "$(dirname "$0")/../.base.sh"
set -e

echo
echo "${BOLD}Install Discord electron client:$END"

aurs=(discord_arch_electron)

# Proceed

echo "${GREEN}Installing...$END"

install_aur "${aurs[@]}"

echo 'Goodbye!'
echo

xdg-open 'https://wiki.archlinux.org/title/Discord'
exit 0
