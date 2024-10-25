#!/bin/bash

# https://wiki.archlinux.org/title/GNOME

gnome() {
  echo
  echo "${BOLD}GNOME:$END"
  echo '1. Groups'
  echo '2. Components'
  echo '3. Extensions'

  case "$(
    get_input \
      "${YELLOW}What to install? \
(1-3/\
$YELLOW${UNDERLINE}B${END}${YELLOW}ack/\
$YELLOW${UNDERLINE}Q${END}${YELLOW}uit)$END" \
      '1' '2' '3' 'b' 'q'
  )" in
    1)
      packages=()

      input="$(
        get_input \
          "${YELLOW}Install package groups? \
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

      if install "${packages[@]}"; then
        echo "${GREEN}Finished.$END"
      fi
      gnome
      ;;
    2)
      packages=()

      input="$(
        get_input \
          "${YELLOW}Install additional components? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'y' 'n'
      )"
      if [[ "$input" == 'y' ]]; then
        packages+=(
          'fwupd'
          'webp-pixbuf-loader'
          'power-profiles-daemon'
          'gst-plugin-pipewire'
        )
      fi

      if install "${packages[@]}"; then
        echo "${GREEN}Finished.$END"
      fi
      gnome
      ;;
    3)
      aurs=()

      input="$(
        get_input \
          "${YELLOW}Install AppIndicators/Top bar icons? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'y' 'n'
      )"
      if [[ "$input" == 'y' ]]; then
        aurs+=('gnome-shell-extension-appindicator')
      fi

      input="$(
        get_input \
          "${YELLOW}Install shell blur? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'y' 'n'
      )"
      if [[ "$input" == 'y' ]]; then
        aurs+=('gnome-shell-extension-blur-my-shell')
      fi

      input="$(
        get_input \
          "${YELLOW}Install rounded corners? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'y' 'n'
      )"
      if [[ "$input" == 'y' ]]; then
        aurs+=('gnome-shell-extension-rounded-window-corners')
      fi

      input="$(
        get_input \
          "${YELLOW}Install better Alt-Tab functionality? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'y' 'n'
      )"
      if [[ "$input" == 'y' ]]; then
        aurs+=('gnome-shell-extension-coverflow-alt-tab-git')
      fi

      input="$(
        get_input \
          "${YELLOW}Install Dash to Dock? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'y' 'n'
      )"
      if [[ "$input" == 'y' ]]; then
        aurs+=('gnome-shell-extension-dash-to-dock')
      fi

      input="$(
        get_input \
          "${YELLOW}Install clipboard history? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'y' 'n'
      )"
      if [[ "$input" == 'y' ]]; then
        aurs+=('gnome-shell-extension-clipboard-indicator')
      fi

      input="$(
        get_input \
          "${YELLOW}Install detailed weather? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'y' 'n'
      )"
      if [[ "$input" == 'y' ]]; then
        aurs+=('gnome-shell-extension-openweather')
      fi

      input="$(
        get_input \
          "${YELLOW}Install sound input/output device selector? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'y' 'n'
      )"
      if [[ "$input" == 'y' ]]; then
        aurs+=('gnome-shell-extension-sound-output-device-chooser')
      fi

      if install_aur "${aurs[@]}"; then
        echo "${GREEN}Finished.$END"
      fi
      gnome
      ;;
    b) main ;;
    q) quit ;;
  esac
}

gnome
