#!/bin/bash

source "$(dirname "$0")/../.base.sh"
set -e

echo
echo "${BOLD}Install Docker engine:$END"

packages=(docker)
services=()

# Additional peripherals

echo "${YELLOW}When to start docker service? (${UNDERLINE}B${END}${YELLOW}oot/${UNDERLINE}F${END}${YELLOW}irst time)$END"
read -r input

if [[ $input == 'B' ]] || [[ $input == 'b' ]]; then
  services+=(docker.service)
elif [[ $input == 'F' ]] || [[ $input == 'f' ]]; then
  services+=(docker.socket)
else
  die 'Unknown input.'
fi

# Proceed

echo "${GREEN}Installing...$END"

install "${packages[@]}"
enable "${services[@]}"

echo 'Goodbye!'
echo

xdg-open 'https://wiki.archlinux.org/title/Docker'
exit 0
