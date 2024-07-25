#!/bin/bash

source "$(dirname "$0")/../.base.sh"
set -e

echo
echo "${BOLD}Install SMB, NMB and discoveries:$END"

packages=(samba)
services=(smb)
commands=()

# Legacy discoveries

echo "${YELLOW}Apply NMB? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read -r input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  services+=(nmb)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

# Discoveries

echo "${YELLOW}Apply Avahi and WSDD? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read -r input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  packages+=(avahi wsdd)
  services+=(avahi-daemon wsdd)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

# Firewalls

echo "${YELLOW}Apply UFW? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read -r input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  check_installed ufw
  commands+=('sudo ufw allow CIFS')
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

echo "${YELLOW}Apply firewalld? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read -r input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  check_installed firewalld
  commands+=('sudo firewall-cmd --permanent --add-service={samba,samba-client,samba-dc} --zone=home')
  commands+=('sudo firewall-cmd --reload')
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

# Proceed

echo "${GREEN}Installing...$END"

install "${packages[@]}"
enable "${services[@]}"
for command in "${commands[@]}"; do ${command}; done

echo "${ITALIC}Create Samba config file and restart to take effect.$END"
echo 'Goodbye!'
echo

xdg-open 'https://wiki.archlinux.org/title/Samba'
exit 0
