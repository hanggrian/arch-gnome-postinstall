#!/bin/bash

source "$(dirname "$0")/../.base.sh"
set -e

echo
echo "${BOLD}Install SmartGit official client:$END"

aurs=(smartgit)

# Proceed

echo "${GREEN}Installing...$END"

install_aur "${aurs[@]}"

echo 'Goodbye!'
echo

xdg-open 'https://www.syntevo.com/smartgit/'
exit 0
