#!/bin/bash

goto_hardware() {
  echo
  echo "${BOLD}Hardware:$END"
  echo '1. CPU microcode'
  echo '2. Intel GPU'
  echo '3. AMD GPU'
  echo '4. NVIDIA GPU'

  case "$(
    get_input \
      "${YELLOW}What to install? \
(1-4/\
$YELLOW${UNDERLINE}B${END}${YELLOW}ack/\
$YELLOW${UNDERLINE}Q${END}${YELLOW}uit)$END" \
      '1' '2' '3' '4' 'b' 'q'
  )" in
    1)
      # https://wiki.archlinux.org/title/Microcode
      packages=()

      input="$(
        get_input \
          "${YELLOW}Install processor microcode? \
(${UNDERLINE}I${END}${YELLOW}ntell/\
${UNDERLINE}A${END}${YELLOW}MD/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'i' 'a' 'n'
      )"
      if [[ "$input" == 'i' ]]; then
        packages+=('intel-ucode')
      elif [[ "$input" == 'a' ]]; then
        packages+=('amd-ucode')
      fi

      if is_not_empty "${packages[@]}"; then
        install "${packages[@]}"
        echo "${GREEN}Finished.$END"
      fi
      goto_hardware
      ;;
    2)
      # https://wiki.archlinux.org/title/Intel_graphics
      packages=()
      aurs=()

      input="$(
        get_input \
          "${YELLOW}Install Intel graphics card? \
(${UNDERLINE}B${END}${YELLOW}roadwell/\
${UNDERLINE}C${END}${YELLOW}offee Lake/\
${UNDERLINE}S${END}${YELLOW}kylake/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'b' 'c' 's' 'n'
      )"
      if [[ "$input" == 'b' ]]; then
        packages+=('intel-media-driver')
      elif [[ "$input" == 'c' ]]; then
        packages+=('libva-intel-driver')
      elif [[ "$input" == 's' ]]; then
        aurs+=('intel-hybrid-codec-driver-git')
      fi

      if is_not_empty "${packages[@]}" || \
        is_not_empty "${aurs[@]}"; then
        install "${packages[@]}"
        install_aur "${aurs[@]}"
        echo "${GREEN}Finished.$END"
      fi
      goto_hardware
      ;;
    3)
      # https://wiki.archlinux.org/title/AMDGPU
      packages=()

      input="$(
        get_input \
          "${YELLOW}Install AMD graphics card? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'y' 'n'
      )"
      if [[ "$input" == 'y' ]]; then
        packages+=('mesa' 'libva-mesa-driver' 'mesa-vdpau' 'vulkan-radeon')
      fi

      if is_not_empty "${packages[@]}"; then
        install "${packages[@]}"
        echo "${GREEN}Finished.$END"
      fi
      goto_hardware
      ;;
    4)
      # https://wiki.archlinux.org/title/NVIDIA
      packages=()
      aurs=()

      input="$(
        get_input \
          "${YELLOW}Install NVIDIA graphics card? \
(${UNDERLINE}M${END}${YELLOW}axwell/\
${UNDERLINE}T${END}${YELLOW}uring/\
${UNDERLINE}K${END}${YELLOW}epler/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'm' 't' 'k' 'n'
      )"
      if [[ "$input" == 'm' ]]; then
        check_dkms

        packages+=('nvidia-dkms' 'mesa' 'libva-mesa-driver' 'mesa-vdpau')
        aurs+=('noveau-fw')
      elif [[ "$input" == 't' ]]; then
        check_dkms

        packages+=('nvidia-open-dkms' 'mesa' 'libva-mesa-driver' 'mesa-vdpau')
        aurs+=('noveau-fw')
      elif [[ "$input" == 'k' ]]; then
        check_dkms

        packages+=('mesa' 'libva-mesa-driver' 'mesa-vdpau')
        aurs+=('nvidia-470xx-dkms' 'noveau-fw')
      fi

      if is_not_empty "${packages[@]}" || \
        is_not_empty "${aurs[@]}"; then
        install "${packages[@]}"
        install_aur "${aurs[@]}"
        echo "${GREEN}Finished.$END"
      fi
      goto_hardware
      ;;
    b) main ;;
    q) quit ;;
  esac
}

goto_hardware
