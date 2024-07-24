#!/bin/bash

source "$(dirname "$0")/../.base.sh"
set -e

echo
echo "${BOLD}Install Mesa and accelerated video decoding on NVIDIA graphics:$END"

packages=()
aurs=()

# Gen

echo "${YELLOW}What is the GPU generation? (${UNDERLINE}M${END}${YELLOW}axwell/${UNDERLINE}T${END}${YELLOW}uring/${UNDERLINE}K${END}${YELLOW}epler)$END"
read input

if [[ $input == 'M' ]] || [[ $input == 'm' ]]; then
  check_dkms
  packages+=(nvidia-dkms mesa libva-mesa-driver mesa-vdpau)
  aurs+=(noveau-fw)
elif [[ $input == 'T' ]] || [[ $input == 't' ]]; then
  check_dkms
  packages+=(nvidia-open-dkms libva-mesa-driver mesa-vdpau)
  aurs+=(noveau-fw)
elif [[ $input == 'K' ]] || [[ $input == 'k' ]]; then
  check_dkms
  packages+=(libva-mesa-driver mesa-vdpau)
  aurs+=(nvidia-470xx-dkms noveau-fw)
else
  die 'Unknown input.'
fi

# Proceed

echo "${GREEN}Installing...$END"
install ${packages[@]}
install_aur ${aurs[@]}

xdg-open 'https://wiki.archlinux.org/title/NVIDIA'

echo 'Goodbye!'
echo
exit 0
