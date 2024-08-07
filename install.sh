#!/bin/bash

readonly END='[0m'
readonly BOLD='[1m'
readonly ITALIC='[3m'
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
  local packages=("$@")
  for package in "${packages[@]}"; do
    sudo pacman -Qi "$package" &> /dev/null
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
    yay -S "${aurs[@]}"
  fi
}

enable() {
  local services=("$@")
  if (( ${#services[@]} != 0 )); then
    for service in "${services[@]}"; do
      systemctl enable "$service"
      if ! systemctl is-active --quiet "$service"; then
          systemctl start "$service"
      fi
    done
  fi
}

echo
echo "$UNDERLINE${BOLD}Arch GNOME Post-Install$END"

main() {
  echo
  echo "${BOLD}Categories:$END"
  echo '1. Prerequisites'
  echo '2. GNOME components'
  echo '3. Security measures'
  echo '4. Hardware drivers'
  echo '5. Device supports'
  echo '6. Development tools'

  case "$(
    get_input \
      "${YELLOW}What to install? \
(1-6/\
$YELLOW${UNDERLINE}Q${END}${YELLOW}uit)$END" \
      '1' '2' '3' '4' '5' '6' 'q'
  )" in
    1)
      source "$(dirname "$0")/.prerequisite.sh"
      main
      ;;
    2)
      source "$(dirname "$0")/.gnome.sh"
      main
      ;;
    3)
      source "$(dirname "$0")/.security.sh"
      main
      ;;
    4)
      source "$(dirname "$0")/.hardware.sh"
      main
      ;;
    5)
      source "$(dirname "$0")/.device.sh"
      main
      ;;
    6)
      source "$(dirname "$0")/.development.sh"
      main
      ;;
    q)
      echo 'Goodbye!'
      echo
      exit 0
      ;;
  esac
}

main
