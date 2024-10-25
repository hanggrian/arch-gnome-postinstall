#!/bin/bash

skip_count=0

echo

# https://wiki.archlinux.org/title/Dynamic_Kernel_Module_Support

input="$(
  get_input \
    "${YELLOW}Install DKMS? \
(${UNDERLINE}S${END}${YELLOW}tandard/\
${UNDERLINE}L${END}${YELLOW}TS/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
    's' 'l' 'n'
)"
if [[ "$input" == 's' ]]; then
  sudo pacman -S 'dkms' 'linux-headers'
elif [[ "$input" == 'l' ]]; then
  sudo pacman -S 'dkms' 'linux-lts-headers'
else
  skip_count=$((skip_count + 1))
fi

# https://wiki.archlinux.org/title/AUR_helpers

input="$(
  get_input \
    "${YELLOW}Install Yay? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
    'y' 'n'
)"
if [[ "$input" == 'y' ]]; then
  sudo pacman -S --needed git base-devel \
    && git clone https://aur.archlinux.org/yay.git \
    && cd yay \
    && makepkg -si
else
  skip_count=$((skip_count + 1))
fi

# https://wiki.archlinux.org/title/Official_repositories

input="$(
  get_input \
    "${YELLOW}Install 32-bit repositories? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
    'y' 'n'
)"
if [[ "$input" == 'y' ]]; then
  sudo sed -i '/\[multilib\]/,/Include/s/^#//' "$PACMAN_CONF"
  sudo pacman -Sy
else
  skip_count=$((skip_count + 1))
fi

if [[ "$skip_count" -lt 3 ]]; then
  echo "${GREEN}Finished.$END"
fi
main
