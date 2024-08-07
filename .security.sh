#!/bin/bash

echo

packages=()
aurs=()
services=()

# MAC

input="$(
  get_input \
    "${YELLOW}Apply mandatory access control? \
(${UNDERLINE}A${END}${YELLOW}ppArmor/\
${UNDERLINE}S${END}${YELLOW}ELinux/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
    'a' 's' 'n'
)"
if [[ "$input" == 'a' ]]; then
  packages+=('apparmor')
  services+=('apparmor.service')
elif [[ "$input" == 's' ]]; then
  git clone https://github.com/archlinuxhardened/selinux.git
  chmod -R +x selinux
  pushd selinux || exit
  ./recv_gpg_keys.sh
  ./build_and_install_all.sh
  popd || exit
  rm -rf selinux
fi

# ClamAV

input="$(
  get_input \
    "${YELLOW}Apply ClamAV? \
(${UNDERLINE}C${END}${YELLOW}LI/\
${UNDERLINE}G${END}${YELLOW}UI/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
    'c' 'g' 'n'
)"
if [[ "$input" == 'c' ]]; then
  packages+=('clamav')
elif [[ "$input" == 'g' ]]; then
  packages+=('clamav' 'clamtk')
  aurs+=('clamtk-gnome')
fi

# Firewall

input="$(
  get_input \
    "${YELLOW}Apply a firewall? \
(${UNDERLINE}U${END}${YELLOW}FW/\
${UNDERLINE}F${END}${YELLOW}irewalld/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
    'u' 'f' 'n'
)"
if [[ "$input" == 'u' ]]; then
  packages+=('ufw')
elif [[ "$input" == 'f' ]]; then
  packages+=('firewalld')
  services+=('firewalld.service')
fi

# Proceed

echo "${GREEN}Installing...$END"

install "${packages[@]}"
enable "${services[@]}"
