#!/bin/bash

source "$(dirname "$0")/../.base.sh"
set -e

echo
echo "${BOLD}Install Mesa, Vulkan and accelerated video decoding on AMDGPU:$END"

packages=()
aurs=()

# 32-bit

echo "${YELLOW}Is this 32-bit? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read -r input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  packages+=(lib32-mesa lib32-vulkan-intel)
elif [[ $input == 'N' ]] || [[ $input == 'n' ]]; then
  packages+=(mesa vulkan-intel)
else
  die 'Unknown input.'
fi

# Xorg

echo "${YELLOW}Is this Xorg? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read -r input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  check_multilib
  packages+=(xf86-video-intel)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

# HWA

echo "${YELLOW}What is the CPU generation? (${UNDERLINE}B${END}${YELLOW}roadwell/${UNDERLINE}C${END}${YELLOW}offee Lake/${UNDERLINE}S${END}${YELLOW}kylake)$END"
read -r input

if [[ $input == 'B' ]] || [[ $input == 'b' ]]; then
  packages+=(intel-media-driver)
elif [[ $input == 'N' ]] || [[ $input == 'n' ]]; then
  packages+=(libva-intel-driver)
elif [[ $input == 'S' ]] || [[ $input == 's' ]]; then
  aurs+=(intel-hybrid-codec-driver-git)
else
  die 'Unknown input.'
fi

# Proceed

echo "${GREEN}Installing...$END"

install "${packages[@]}"
install_aur "${aurs[@]}"

echo 'Goodbye!'
echo

xdg-open 'https://wiki.archlinux.org/title/Intel_graphics'
exit 0
