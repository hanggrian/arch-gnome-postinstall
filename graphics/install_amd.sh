#!/bin/bash

readonly HOME="$(dirname "$0")/.."
source "$HOME/.base.sh"

echo
echo "$BOLD${YELLOW}Install Mesa, Vulkan and accelerated video decoding? (${UNDERLINE}Y$END$BOLD${YELLOW}es/${UNDERLINE}N$END$BOLD${YELLOW}o)$END"
read is_install

if [[ $is_install == 'Y' ]] || [[ $is_install == 'y' ]]; then
  packages=()
elif [[ $is_install == 'N' ]] || [[ $is_install == 'n' ]]; then
  echo 'Goodbye!'
  echo
  exit 0
else
  die 'Unknown input.'
fi

# 32-bit

echo "${YELLOW}Is this 32-bit? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read is_32bit

if [[ $is_32bit == 'Y' ]] || [[ $is_32bit == 'y' ]]; then
  packages+=(lib32-mesa lib32-libva-mesa-driver lib32-mesa-vdpau lib32-vulkan-radeon)
elif [[ $is_32bit == 'N' ]] || [[ $is_32bit == 'n' ]]; then
  packages+=(mesa libva-mesa-driver mesa-vdpau vulkan-radeon)
else
  die 'Unknown input.'
fi

# Xorg

echo "${YELLOW}Is this Xorg? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read is_xorg

if [[ $is_xorg == 'Y' ]] || [[ $is_xorg == 'y' ]]; then
  check_multilib
  packages+=(xf86-video-amdgpu)
elif [[ $is_xorg != 'N' ]] && [[ $is_xorg != 'n' ]]; then
  die 'Unknown input.'
fi

echo "${GREEN}Installing...$END"
sudo pacman -S ${packages[@]}

xdg-open 'https://wiki.archlinux.org/title/AMDGPU'

echo 'Goodbye!'
echo
exit 0
