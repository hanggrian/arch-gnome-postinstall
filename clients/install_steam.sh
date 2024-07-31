#!/bin/bash

source "$(dirname "$0")/../.base.sh"
set -e

echo
echo "${BOLD}Install Steam 32-bit client:$END"

check_multilib
packages=(steam)

# Proceed

echo "${GREEN}Installing...$END"

install "${packages[@]}"

echo 'Goodbye!'
echo

xdg-open 'https://wiki.archlinux.org/title/Steam'
exit 0
