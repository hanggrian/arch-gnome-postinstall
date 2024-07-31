#!/bin/bash

source "$(dirname "$0")/.base.sh"
set -e

echo
echo "${BOLD}Install a firewall:$END"

packages=()
services=()

# UFW

echo "${YELLOW}Apply Uncomplicated Firewall? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read -r input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  packages+=(ufw)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

# Firewalld

echo "${YELLOW}Apply Firewalld? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read -r input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  packages+=(firewalld)
  services+=(firewalld.service)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

# Proceed

echo "${GREEN}Installing...$END"

install "${packages[@]}"
enable "${services[@]}"

echo 'Goodbye!'
echo

xdg-open 'https://wiki.archlinux.org/title/Category:Firewalls'
exit 0
