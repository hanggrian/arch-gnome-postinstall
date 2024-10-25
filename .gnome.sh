#!/bin/bash

# https://wiki.archlinux.org/title/GNOME

goto_gnome() {
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

      if is_not_empty "${packages[@]}"; then
        install "${packages[@]}"
        echo "${GREEN}Finished.$END"
      fi
      goto_gnome
      ;;
    2)
      packages=()

      input="$(
        get_input \
          "${YELLOW}Install fwupd for Device Security Settings? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'y' 'n'
      )"
      if [[ "$input" == 'y' ]]; then
        packages+=('fwupd')
      fi

      input="$(
        get_input \
          "${YELLOW}Install WebP support? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'y' 'n'
      )"
      if [[ "$input" == 'y' ]]; then
        packages+=('webp-pixbuf-loader')
      fi

      input="$(
        get_input \
          "${YELLOW}Install power profile support? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'y' 'n'
      )"
      if [[ "$input" == 'y' ]]; then
        packages+=('power-profiles-daemon')
      fi

      input="$(
        get_input \
          "${YELLOW}Install screencast to enable screen recording? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'y' 'n'
      )"
      if [[ "$input" == 'y' ]]; then
        packages+=('gst-plugin-pipewire')
      fi

      if is_not_empty "${packages[@]}"; then
        install "${packages[@]}"
        echo "${GREEN}Finished.$END"
      fi
      goto_gnome
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

      if is_not_empty "${aurs[@]}"; then
        install_aur "${aurs[@]}"
        echo "${GREEN}Finished.$END"
      fi
      goto_gnome
      ;;
    b) main ;;
    q) quit ;;
  esac
}

goto_gnome
