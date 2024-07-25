#!/bin/bash

source "$(dirname "$0")/../.base.sh"
set -e

echo
echo "${BOLD}Install Razer peripherals:$END"

check_dkms
packages=(openrazer-daemon)
aurs=(razercommander-git)

# Proceed

if ! getent group plugdev > /dev/null 2>&1; then
  sudo groupadd plugdev
fi
sudo gpasswd -a "$USER" plugdev

echo "${GREEN}Installing...$END"

install "${packages[@]}"
install_aur "${aurs[@]}"

echo "${ITALIC}User plugdev added, restart to take effect.$END"
echo 'Goodbye!'
echo

xdg-open 'https://wiki.archlinux.org/title/Razer_peripherals'
exit 0
