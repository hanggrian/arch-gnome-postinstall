#!/bin/bash

source "$(dirname "$0")/../.base.sh"
set -e

echo
echo "${BOLD}Install Mesa, Vulkan and accelerated video decoding on Intel graphics:$END"

packages=()

# 32-bit

echo "${YELLOW}Is this 32-bit? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  packages+=(lib32-mesa lib32-libva-mesa-driver lib32-mesa-vdpau lib32-vulkan-radeon)
elif [[ $input == 'N' ]] || [[ $input == 'n' ]]; then
  packages+=(mesa libva-mesa-driver mesa-vdpau vulkan-radeon)
else
  die 'Unknown input.'
fi

# Xorg

echo "${YELLOW}Is this Xorg? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  check_multilib
  packages+=(xf86-video-amdgpu)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

# Proceed

echo "${GREEN}Installing...$END"
install ${packages[@]}

xdg-open 'https://wiki.archlinux.org/title/AMDGPU'

echo 'Goodbye!'
echo
exit 0
