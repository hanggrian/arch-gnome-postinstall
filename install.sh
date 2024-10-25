#!/bin/bash

readonly END='[0m'
readonly BOLD='[1m'
readonly UNDERLINE='[4m'
readonly RED='[91m'
readonly GREEN='[92m'
readonly YELLOW='[93m'

readonly PACMAN_CONF='/etc/pacman.conf'

set -e

die() {
  echo "$RED$*$END"
  echo 'Goodbye!'
  echo
  exit 1
} >&2

get_input() {
  local message="$1"
  shift
  local values=("$@")
  local input
  read -r -p "$message " input

  for value in "${values[@]}"; do
    if [[ $(echo "$input" | tr '[:upper:]' '[:lower:]') == "$value" ]]; then
      echo "$value"
      return 0
    fi
  done

  get_input "${RED}Invalid input, try again...$END" "${values[@]}"
}

check_multilib() {
  if grep -q '^\[multilib\]' "$PACMAN_CONF" \
    && grep -q '^Include = /etc/pacman.d/mirrorlist' "$PACMAN_CONF"; then
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
  local package="$1"
  sudo pacman -Qi "$package" &> /dev/null
  if [[ $? -ne 0 ]]; then
    return 1
  fi
  return 0
}

is_not_empty() {
  local array=("$@")
  if (( ${#array[@]} != 0 )); then
    return 0
  fi
  return 1
}

install() {
  local packages=("$@")
  if is_not_empty "${packages[@]}"; then
    sudo pacman -S "${packages[@]}"
    return 0
  fi
  return 1
}

install_aur() {
  local aurs=("$@")
  if is_not_empty "${aurs[@]}"; then
    yay -S "${aurs[@]}"
    return 0
  fi
  return 1
}

enable() {
  local services=("$@")
  if is_not_empty "${services[@]}"; then
    for service in "${services[@]}"; do
      sudo systemctl enable "$service"
    done
    return 0
  fi
  return 1
}

quit() {
  echo 'Goodbye!'
  echo
  exit 0
}

echo
echo "$UNDERLINE${BOLD}Arch GNOME Post-Install$END"

main() {
  echo
  echo "${BOLD}Main:$END"
  echo '1. Prerequisites'
  echo '2. Pacman utilities'
  echo '3. GNOME components'
  echo '4. Security measures'
  echo '5. Hardware drivers'
  echo '6. Device supports'
  echo '7. Development tools'

  case "$(
    get_input \
      "${YELLOW}Select a category? \
(1-7/\
$YELLOW${UNDERLINE}Q${END}${YELLOW}uit)$END" \
      '1' '2' '3' '4' '5' '6' '7' 'q'
  )" in
    1) source "$(dirname "$0")/.prerequisite.sh" ;;
    2) source "$(dirname "$0")/.pacman.sh" ;;
    3) source "$(dirname "$0")/.gnome.sh" ;;
    4) source "$(dirname "$0")/.security.sh" ;;
    5) source "$(dirname "$0")/.hardware.sh" ;;
    6) source "$(dirname "$0")/.device.sh" ;;
    7) source "$(dirname "$0")/.development.sh" ;;
    q) quit ;;
  esac
}

main
