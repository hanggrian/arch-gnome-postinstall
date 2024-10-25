#!/bin/bash

goto_pacman() {
  echo
  echo "${BOLD}Pacman:$END"
  echo '1. Contrib'
  echo '2. Reflector'

  case "$(
    get_input \
      "${YELLOW}What to install? \
(1-2/\
$YELLOW${UNDERLINE}B${END}${YELLOW}ack/\
$YELLOW${UNDERLINE}Q${END}${YELLOW}uit)$END" \
      '1' '2' 'b' 'q'
  )" in
    1)
      # https://wiki.archlinux.org/title/Pacman
      packages=()

      input="$(
        get_input \
          "${YELLOW}Install contributed scripts? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'y' 'n'
      )"
      if [[ "$input" == 'y' ]]; then
        packages+=('pacman-contrib')
      fi

      if is_not_empty "${packages[@]}"; then
        install "${packages[@]}"
        echo "${GREEN}Finished.$END"
      fi
      goto_pacman
      ;;
    2)
      # https://wiki.archlinux.org/title/Reflector
      packages=()

      input="$(
        get_input \
          "${YELLOW}Install mirror list generator? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'y' 'n'
      )"
      if [[ "$input" == 'y' ]]; then
        packages+=('reflector')
      fi

      if is_not_empty "${packages[@]}"; then
        install "${packages[@]}"
        echo "${GREEN}Finished.$END"
      fi
      goto_pacman
      ;;
    b) main ;;
    q) quit ;;
  esac
}

goto_pacman
