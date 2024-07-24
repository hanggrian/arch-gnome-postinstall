#!/bin/bash

readonly HOME="$(dirname "$0")/.."
source "$HOME/.base.sh"

echo
echo "$BOLD${YELLOW}Verify VA-API and VDPAU? (${UNDERLINE}Y$END$BOLD${YELLOW}es/${UNDERLINE}N$END$BOLD${YELLOW}o)$END"
read is_verify

if [[ $is_verify == 'Y' ]] || [[ $is_verify == 'y' ]]; then
  packages=()
elif [[ $is_verify == 'N' ]] || [[ $is_verify == 'n' ]]; then
  echo 'Goodbye!'
  echo
  exit 0
else
  die 'Unknown input.'
fi

# Intel

if is_installed intel-media-driver || is_installed libva-intel-driver || is_installed libva-intel-driver-g45-h264 || is_installed intel-hybrid-codec-driver-git; then
  echo "${GREEN}Intel VA-API drivers found.$END"
  
  packages+=(libva-utils)
  commands+=(vainfo)
fi

# Nvidia

if is_installed noveau-fw || is_installed nvidia-utils; then
  echo "${GREEN}Nvidia VDPAU drivers found.$END"
  
  packages+=(vdpauinfo)
  commands+=(vdpauinfo)
fi

# AMD

if is_installed libva-mesa-driver || is_installed lib32-libva-mesa-driver; then
  echo "${GREEN}AMD VA-API drivers found.$END"
  
  packages+=(libva-utils)
  commands+=(vainfo)
fi
if is_installed mesa-vdpau || is_installed lib32-mesa-vdpau; then
  echo "${GREEN}AMD VDPAU drivers found.$END"
  
  packages+=(vdpauinfo)
  commands+=(vdpauinfo)
fi

packages=(`printf "%s " ${packages[@]} | sort -n -u`)
commands=(`printf "%s " ${commands[@]} | sort -n -u`)

echo "${GREEN}Verifying...$END"
sudo pacman -S ${packages[@]}
for command in ${commands[@]}; do
  ${command}
done

xdg-open 'https://wiki.archlinux.org/title/Hardware_video_acceleration'

echo 'Goodbye!'
echo
exit 0
