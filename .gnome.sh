#!/bin/bash

echo

packages=()
aurs=()

# Groups

input="$(
  get_input \
    "${YELLOW}Apply groups? \
(${UNDERLINE}S${END}${YELLOW}tandard/\
${UNDERLINE}E${END}${YELLOW}xtra/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
    's' 'e' 'n'
)"
if [[ "$input" == 's' ]]; then
  packages+=('gnome')
elif [[ "$input" == 'e' ]]; then
  packages+=('gnome' 'gnome-extra')
fi

# Components

if [[ "$(
  get_input \
    "${YELLOW}Apply components? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
      'y' 'n'
    )" == 'y'
  ]]; then
  packages+=(
    'fwupd'
    'webp-pixbuf-loader'
    'power-profiles-daemon'
    'gst-plugin-pipewire'
  )
fi

# Extensions

if [[ "$(
  get_input \
    "${YELLOW}Apply extensions? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
      'y' 'n'
    )" == 'y'
  ]]; then
  aurs+=(
    'gnome-shell-extension-appindicator'
    'gnome-shell-extension-blur-my-shell'
    'gnome-shell-extension-rounded-window-corners'
    'gnome-shell-extension-coverflow-alt-tab-git'
    'gnome-shell-extension-dash-to-dock'
    'gnome-shell-extension-clipboard-indicator'
    'gnome-shell-extension-openweather'
    'gnome-shell-extension-sound-output-device-chooser'
  )
fi

# Proceed

echo "${GREEN}Installing...$END"

install "${packages[@]}"
install_aur "${aurs[@]}"
