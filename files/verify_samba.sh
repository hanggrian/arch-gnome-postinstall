#!/bin/bash

source "$(dirname "$0")/../.base.sh"
set -e

echo
echo "${BOLD}Verify Samba share:$END"

# Hostname

echo "${YELLOW}Enter share's hostname?$END"
read -r hostname

packages=('smbclient')
commands=('sudo modprobe cifs' "smbclient -L $hostname -U%")

# Proceed

echo "${GREEN}Verifying...$END"

install "${packages[@]}"
for command in "${commands[@]}"; do ${command}; done

echo 'Goodbye!'
echo

xdg-open 'https://wiki.archlinux.org/title/Samba#Client'
exit 0
