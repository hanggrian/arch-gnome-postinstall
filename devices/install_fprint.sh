#!/bin/bash

source "$(dirname "$0")/../.base.sh"
set -e

echo
echo "${BOLD}Install Razer peripherals:$END"

packages=(fprintd imagemagick)
aurs=()

# Additional peripherals

echo "${YELLOW}Have touch-based sensors? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read -r input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  aurs+=(libfprint-tod-git)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

echo "${YELLOW}Have ELAN 0C4C sensors? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read -r input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  aurs+=(libfprint-elanmoc2-git)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

echo "${YELLOW}Have ELAN 0C4C or 0C00 sensors? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read -r input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  aurs+=(libfprint-elanmoc2-newdrvs-git)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

# Proceed

echo "${GREEN}Installing...$END"

install "${packages[@]}"
install_aur "${aurs[@]}"

echo 'Goodbye!'
echo

xdg-open 'https://wiki.archlinux.org/title/Fprint'
exit 0
