#!/bin/bash

source "$(dirname "$0")/.base.sh"
set -e

echo
echo "${BOLD}Install GNOME system-wide extensions:$END"

packages=()
aurs=(extension-manager)

# AppIndicators

echo "${YELLOW}Apply AppIndicators/Top bar icons? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  packages+=(gnome-shell-extension-appindicator)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

# Blur my Shell

echo "${YELLOW}Apply Blur my Shell? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  aurs+=(gnome-shell-extension-blur-my-shell)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

# Rounded Window Corners

echo "${YELLOW}Apply Rounded Window Corners? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  aurs+=(gnome-shell-extension-rounded-window-corners)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

# CoverflowAltTab

echo "${YELLOW}Apply CoverflowAltTab? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  aurs+=(gnome-shell-extension-coverflow-alt-tab-git)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

# Dash to Dock

echo "${YELLOW}Apply Dash to Dock? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  aurs+=(gnome-shell-extension-dash-to-dock)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

# Clipboard Indicator

echo "${YELLOW}Apply Clipboard Indicator? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  aurs+=(gnome-shell-extension-clipboard-indicator)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

# OpenWeather

echo "${YELLOW}Apply OpenWeather? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  aurs+=(gnome-shell-extension-openweather)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

# Sound Input & Output Device Chooser

echo "${YELLOW}Apply Sound Input & Output Device Chooser? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  aurs+=(gnome-shell-extension-sound-output-device-chooser)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

# Proceed

echo "${GREEN}Installing...$END"
install ${packages[@]}
install_aur ${aurs[@]}

xdg-open 'https://wiki.archlinux.org/title/GNOME#Extensions'

echo 'Goodbye!'
echo
exit 0
