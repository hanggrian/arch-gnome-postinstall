#!/bin/bash

source "$(dirname "$0")/../.base.sh"
set -e

readonly USER_DIRS="$HOME/.config/user-dirs.dirs"

set_xgd_dir() {
  local key=$1
  local value=$2
  sed -i "s|$key=\".*\"|$key=\"$value\"|" $USER_DIRS
}

prompt_xdg_dir() {
  echo "${YELLOW}Hide $1? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
  read -r input

  if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
    xdg_entries+=("$2")
  elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
    die 'Unknown input.'
  fi
}

echo
echo "${BOLD}Hide/show Files sidebar item:$END"

xdg_entries=()

# Show/hide

echo "${YELLOW}Show all or hide directories? (${UNDERLINE}S${END}${YELLOW}how/${UNDERLINE}H${END}${YELLOW}ide)$END"
read -r input

if [[ $input == 'S' ]] || [[ $input == 's' ]]; then
  message="${GREEN}Showing...$END"

  set_xgd_dir 'XDG_DOWNLOAD_DIR' "\$HOME/Downloads"
  set_xgd_dir 'XDG_DOCUMENTS_DIR' "\$HOME/Documents"
  set_xgd_dir 'XDG_MUSIC_DIR' "\$HOME/Music"
  set_xgd_dir 'XDG_PICTURES_DIR' "\$HOME/Pictures"
  set_xgd_dir 'XDG_VIDEOS_DIR' "\$HOME/Videos"
elif [[ $input == 'H' ]] || [[ $input == 'h' ]]; then
  message="${GREEN}Hiding...$END"

  prompt_xdg_dir 'Downloads' 'XDG_DOWNLOAD_DIR'
  prompt_xdg_dir 'Documents' 'XDG_DOCUMENTS_DIR'
  prompt_xdg_dir 'Music' 'XDG_MUSIC_DIR'
  prompt_xdg_dir 'Pictures' 'XDG_PICTURES_DIR'
  prompt_xdg_dir 'Videos' 'XDG_VIDEOS_DIR'
else
  die 'Unknown input.'
fi

# Proceed

echo "$message"

for xdg_entry in "${xdg_entries[@]}"; do
  set_xgd_dir "$xdg_entry" "\$HOME"
done

echo "${ITALIC}Logout to take effect.$END"
echo 'Goodbye!'
echo

exit 0
