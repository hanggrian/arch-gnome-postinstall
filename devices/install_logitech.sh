#!/bin/bash

source "$(dirname "$0")/../.base.sh"
set -e

echo
echo "${BOLD}Install Logitech peripherals:$END"

packages=(solaar)
aurs=()

# Additional peripherals

echo "${YELLOW}Have Logitech G300? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read -r input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  aurs+=(ratslap)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

echo "${YELLOW}Have Logitech MX Revolution? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read -r input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  packages+=(xbindkeys)
  aurs+=(xvkbd)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

# Proceed

echo "${GREEN}Installing...$END"

install "${packages[@]}"
install_aur "${aurs[@]}"

echo 'Goodbye!'
echo

xdg-open 'https://wiki.archlinux.org/title/Logitech_MX_Master'
exit 0
