#!/bin/bash

readonly END=[0m
readonly BOLD=[1m
readonly UNDERLINE=[4m
readonly RED=[91m
readonly GREEN=[92m
readonly YELLOW=[93m

readonly PACMAN_CONF=/etc/pacman.conf

die() {
  echo "$RED$*$END"
  echo 'Goodbye!'
  echo
  exit 1
} >&2

check_multilib() {
  if grep -q '^\[multilib\]' "$PACMAN_CONF" && grep -q '^Include = /etc/pacman.d/mirrorlist' "$PACMAN_CONF"; then
    echo "${GREEN}The multilib repository is enabled.$END"
  else
    die 'The multilib repository is not enabled.'
  fi
}

is_installed() {
  for package in "$@"; do
    pacman -Qi "$package" &> /dev/null
    if [ $? -ne 0 ]; then
      return 1
    fi
  done
  return 0
}