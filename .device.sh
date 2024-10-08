#!/bin/bash

echo

packages=()
aurs=()
services=()
commands=()

# Fprint

if [[ "$(
  get_input \
    "${YELLOW}Apply fingerprint devices? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
      'y' 'n'
    )" == 'y'
  ]]; then
  packages+=('fprintd' 'imagemagick')
fi

# Camera

if [[ "$(
  get_input \
    "${YELLOW}Apply camera devices? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
      'y' 'n'
    )" == 'y'
  ]]; then
  packages+=('cameractrls')
fi

# Broadcom

if [[ "$(
  get_input \
    "${YELLOW}Apply Broadcom devices? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
      'y' 'n'
    )" == 'y'
  ]]; then
  check_dkms
  packages+=('broadcom-wl-dkms')
  commands+=('sudo modprobe wl')
fi

# Logitech

if [[ "$(
  get_input \
    "${YELLOW}Apply Logitech mice? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
      'y' 'n'
    )" == 'y'
  ]]; then
  packages+=('solaar')
fi

# Razer

if [[ "$(
  get_input \
    "${YELLOW}Apply Razer peripherals? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
      'y' 'n'
    )" == 'y'
  ]]; then
  check_dkms
  packages+=('openrazer-daemon')
  aurs+=('razercommander-git')

  if ! getent group plugdev > /dev/null 2>&1; then
    sudo groupadd plugdev
  fi
  sudo gpasswd -a "$USER" plugdev
fi

# CoolerControl

if [[ "$(
  get_input \
    "${YELLOW}Apply CoolerControl? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
      'y' 'n'
    )" == 'y'
  ]]; then
  packages+=('lm_sensors')
  aurs+=('coolercontrol')
  services+=('coolercontrold')
  commands+=('sudo sensors-detect' 'sudo systemctl restart coolercontrold')
fi

# Proceed

echo "${GREEN}Installing...$END"

install "${packages[@]}"
install_aur "${aurs[@]}"
enable "${services[@]}"
for command in "${commands[@]}"; do ${command}; done
