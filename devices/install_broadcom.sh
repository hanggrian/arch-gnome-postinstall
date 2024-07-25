#!/bin/bash

source "$(dirname "$0")/../.base.sh"
set -e

echo
echo "${BOLD}Install Broadcom wireless:$END"

check_dkms
packages=(broadcom-wl-dkms)
commands=('sudo modprobe wl')

# Proceed

echo "${GREEN}Installing...$END"

install "${packages[@]}"
for command in "${commands[@]}"; do ${command}; done

echo 'Goodbye!'
echo

xdg-open 'https://wiki.archlinux.org/title/Broadcom_wireless'
exit 0
