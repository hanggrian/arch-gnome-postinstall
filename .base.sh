#!/bin/bash

readonly END='[0m'
readonly BOLD='[1m'
readonly ITALIC='[3m'
readonly UNDERLINE='[4m'
readonly RED='[91m'
readonly GREEN='[92m'
readonly YELLOW='[93m'

readonly PACMAN_CONF='/etc/pacman.conf'

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

check_dkms() {
  if is_installed dkms; then
    echo "${GREEN}DKMS is installed.$END"
  else
    die 'The DKMS package is not installed.'
  fi
}

check_installed() {
  local package="$1"
  if is_installed "$package"; then
    echo "${GREEN}$package is installed.$END"
  else
    die "$package is not installed."
  fi
}

is_installed() {
  local packages=("$@")
  for package in "${packages[@]}"; do
    pacman -Qi "$package" &> /dev/null
    if [[ $? -ne 0 ]]; then
      return 1
    fi
  done
  return 0
}

install() {
  local packages=("$@")
  if (( ${#packages[@]} != 0 )); then
    sudo pacman -S "${packages[@]}"
  fi
}

install_aur() {
  local aurs=("$@")
  if (( ${#aurs[@]} != 0 )); then
    for aur in "${aurs[@]}"; do
      git clone "https://aur.archlinux.org/$aur.git"
      pushd $aur
      makepkg -si
      popd
      rm -rf "$aur"
    done
  fi
}

enable() {
  local services=("$@")
  if (( ${#services[@]} != 0 )); then
    for service in "${services[@]}"; do
      sudo systemctl enable "$service"
      if ! systemctl is-active --quiet "$service"; then
          sudo systemctl start "$service"
      fi
    done
  fi
}

distinct() {
  local array=("$@")
  printf "%s\n" "${array[@]}" | sort -n -u
}
