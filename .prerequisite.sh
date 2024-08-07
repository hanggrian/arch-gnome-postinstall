#!/bin/bash

echo

packages=()

# DKMS

input="$(
  get_input \
    "${YELLOW}Install DKMS? \
(${UNDERLINE}S${END}${YELLOW}tandard/\
${UNDERLINE}L${END}${YELLOW}TS/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
    's' 'l' 'n'
)"
if [[ "$input" == 's' ]]; then
  packages+=('dkms' 'linux-headers')
elif [[ "$input" == 'l' ]]; then
  packages+=('dkms' 'linux-lts-headers')
fi

# Yay

if [[ "$(
  get_input \
    "${YELLOW}Install Yay? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
      'y' 'n'
    )" == 'y'
  ]]; then
  sudo pacman -S --needed git base-devel \
    && git clone https://aur.archlinux.org/yay.git \
    && cd yay \
    && makepkg -si
fi

# Multilib

if [[ "$(
  get_input \
    "${YELLOW}Enable multilib? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
      'y' 'n'
    )" == 'y'
  ]]; then
  sudo sed -i '/\[multilib\]/,/Include/s/^#//' "$PACMAN_CONF"
  sudo pacman -Sy
fi

# Proceed

echo "${GREEN}Installing...$END"

install "${packages[@]}"
