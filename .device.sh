#!/bin/bash

create_plugdev() {
  if ! getent group plugdev > /dev/null 2>&1; then
    sudo groupadd plugdev
  fi
}

goto_device() {
  echo
  echo "${BOLD}Device:$END"
  echo '1. Logitech'
  echo '2. Razer'
  echo '3. Broadcom'
  echo '4. Generic webcam'
  echo '5. Generic fingerprint'
  echo '6. Input remap utility'
  echo '7. Fan control utility'

  case "$(
    get_input \
      "${YELLOW}What to install? \
(1-7/\
$YELLOW${UNDERLINE}B${END}${YELLOW}ack/\
$YELLOW${UNDERLINE}Q${END}${YELLOW}uit)$END" \
      '1' '2' '3' '4' '5' '6' '7' 'b' 'q'
  )" in
    1)
      # https://wiki.archlinux.org/title/Logitech_Unifying_Receiver
      packages=()

      input="$(
        get_input \
          "${YELLOW}Install Logitech device manager? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'y' 'n'
      )"
      if [[ "$input" == 'y' ]]; then
        packages+=('solaar')
      fi

      if is_not_empty "${packages[@]}"; then
        install "${packages[@]}"
        echo "${GREEN}Finished.$END"

        create_plugdev
        udevadm control --reload-rules
      fi
      goto_device
      ;;
    2)
      # https://wiki.archlinux.org/title/Razer_peripherals
      packages=()
      aurs=()

      input="$(
        get_input \
          "${YELLOW}Install Razer device manager? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'y' 'n'
      )"
      if [[ "$input" == 'y' ]]; then
        check_dkms

        packages+=('openrazer-daemon')
        aurs+=('razercommander-git')
      fi

      if is_not_empty "${packages[@]}" || \
        is_not_empty "${aurs[@]}"; then
        install "${packages[@]}"
        install_aur "${aurs[@]}"
        echo "${GREEN}Finished.$END"

        create_plugdev
        gpasswd -a "$USER" plugdev
      fi
      goto_device
      ;;
    3)
      # https://wiki.archlinux.org/title/Broadcom_wireless
      packages=()

      input="$(
        get_input \
          "${YELLOW}Install Broadcom Wi-Fi driver? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'y' 'n'
      )"
      if [[ "$input" == 'y' ]]; then
        check_dkms

        packages+=('broadcom-wl-dkms')

      fi

      if is_not_empty "${packages[@]}"; then
        install "${packages[@]}"
        echo "${GREEN}Finished.$END"

        sudo modprobe 'wl'
      fi
      goto_device
      ;;
    4)
      # https://wiki.archlinux.org/title/Webcam_setup
      packages=()

      input="$(
        get_input \
          "${YELLOW}Install camera configuration tools? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'y' 'n'
      )"
      if [[ "$input" == 'y' ]]; then
        packages+=('cameractrls')
      fi

      if is_not_empty "${packages[@]}"; then
        install "${packages[@]}"
        echo "${GREEN}Finished.$END"
      fi
      goto_device
      ;;
    5)
      # https://wiki.archlinux.org/title/Fprint
      packages=()

      input="$(
        get_input \
          "${YELLOW}Install fingerprint reader? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'y' 'n'
      )"
      if [[ "$input" == 'y' ]]; then
        packages+=('fprintd' 'imagemagick')
      fi

      if is_not_empty "${packages[@]}"; then
        install "${packages[@]}"
        echo "${GREEN}Finished.$END"
      fi
      goto_device
      ;;
    6)
      # https://wiki.archlinux.org/title/Input_remap_utilities
      aurs=()
      services=()

      input="$(
        get_input \
          "${YELLOW}Install input remap tools? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'y' 'n'
      )"
      if [[ "$input" == 'y' ]]; then
        aurs+=('input-remapper-git')
        services+=('input-remapper.service')
      fi

      if is_not_empty "${aurs[@]}" || \
        is_not_empty "${services[@]}"; then
        install_aur "${aurs[@]}"
        enable "${services[@]}"
        echo "${GREEN}Finished.$END"
      fi
      goto_device
      ;;
    7)
      # https://wiki.archlinux.org/title/Fan_speed_control
      aurs=()
      services=()

      input="$(
        get_input \
          "${YELLOW}Install fan control tools? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'y' 'n'
      )"
      if [[ "$input" == 'y' ]]; then
        aurs+=('coolercontrol')
        services+=('coolercontrold.service')
      fi

      if is_not_empty "${aurs[@]}" || \
        is_not_empty "${services[@]}"; then
        install_aur "${aurs[@]}"
        enable "${services[@]}"
        echo "${GREEN}Finished.$END"
      fi
      goto_device
      ;;
    b) main ;;
    q) quit ;;
  esac
}

goto_device
