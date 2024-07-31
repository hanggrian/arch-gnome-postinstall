#!/bin/bash

source "$(dirname "$0")/../.base.sh"
set -e

echo
echo "${BOLD}Install WhatsApp GTK client:$END"

aurs=(whatstux)

# Proceed

echo "${GREEN}Installing...$END"

install_aur "${aurs[@]}"

echo 'Goodbye!'
echo

xdg-open 'https://wiki.archlinux.org/title/WhatsApp'
exit 0
