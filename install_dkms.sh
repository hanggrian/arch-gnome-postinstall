#!/bin/bash

source "$(dirname "$0")/.base.sh"
set -e

echo
echo "${BOLD}Install Dynamic Kernel Module Support:$END"

packages=(dkms)

# LTS

echo "${YELLOW}Is this LTS kernel? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read -r input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  packages+=(linux-lts-headers)
elif [[ $input == 'N' ]] || [[ $input == 'n' ]]; then
  packages+=(linux-headers)
else
  die 'Unknown input.'
fi

# Proceed

echo "${GREEN}Installing...$END"

install "${packages[@]}"

echo 'Goodbye!'
echo

xdg-open 'https://wiki.archlinux.org/title/Dynamic_Kernel_Module_Support'
exit 0
