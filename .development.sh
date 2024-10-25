#!/bin/bash

goto_development() {
  echo
  echo "${BOLD}Development:$END"
  echo '1. Docker'
  echo '2. Java'
  echo '3. Python'

  case "$(
    get_input \
      "${YELLOW}What to install? \
(1-3/\
$YELLOW${UNDERLINE}B${END}${YELLOW}ack/\
$YELLOW${UNDERLINE}Q${END}${YELLOW}uit)$END" \
      '1' '2' '3' 'b' 'q'
  )" in
    1)
      # https://wiki.archlinux.org/title/Docker
      packages=()
      aurs=()
      services=()

      input="$(
        get_input \
          "${YELLOW}Install Docker engine and Docker Desktop? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'y' 'n'
      )"
      if [[ "$input" == 'y' ]]; then
        packages+=('docker')
        aurs+=('docker-desktop')
        services+=('docker.service')
      fi

      if is_not_empty "${packages[@]}" || \
        is_not_empty "${aurs[@]}" || \
        is_not_empty "${services[@]}"; then
        install "${packages[@]}"
        install_aur "${aurs[@]}"
        enable "${services[@]}"
        echo "${GREEN}Finished.$END"
      fi
      goto_development
      ;;
    2)
      # https://wiki.archlinux.org/title/Java
      #
      # The OpenJDK is purposely ignored because it is not recommended for
      # development, see https://whichjdk.com/.
      aurs=()

      input="$(
        get_input \
          "${YELLOW}Install Java latest version? \
(${UNDERLINE}O${END}${YELLOW}racle/\
${UNDERLINE}T${END}${YELLOW}emurin/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'o' 't' 'n'
      )"
      if [[ "$input" == 'o' ]]; then
        aurs+=('jdk-lts')
      elif [[ "$input" == 't' ]]; then
        aurs+=('jdk-temurin')
      fi

      input="$(
        get_input \
          "${YELLOW}Install Java version 8? \
(${UNDERLINE}O${END}${YELLOW}racle/\
${UNDERLINE}T${END}${YELLOW}emurin/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'o' 't' 'n'
      )"
      if [[ "$input" == 'o' ]]; then
        aurs+=('jdk8')
      elif [[ "$input" == 't' ]]; then
        aurs+=('jdk8-temurin')
      fi

      input="$(
        get_input \
          "${YELLOW}Install Java version 11? \
(${UNDERLINE}O${END}${YELLOW}racle/\
${UNDERLINE}T${END}${YELLOW}emurin/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'o' 't' 'n'
      )"
      if [[ "$input" == 'o' ]]; then
        aurs+=('jdk11')
      elif [[ "$input" == 't' ]]; then
        aurs+=('jdk11-temurin')
      fi

      input="$(
        get_input \
          "${YELLOW}Install Java version 17? \
(${UNDERLINE}T${END}${YELLOW}emurin/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          't' 'n'
      )"
      if [[ "$input" == 't' ]]; then
        aurs+=('jdk17-temurin')
      fi

      input="$(
        get_input \
          "${YELLOW}Install Java version 21? \
(${UNDERLINE}T${END}${YELLOW}emurin/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          't' 'n'
      )"
      if [[ "$input" == 't' ]]; then
        aurs+=('jdk21-temurin')
      fi

      if is_not_empty "${aurs[@]}"; then
        install_aur "${aurs[@]}"
        echo "${GREEN}Finished.$END"
      fi
      goto_development
      ;;
    3)
      # https://wiki.archlinux.org/title/Python
      aurs=()

      input="$(
        get_input \
          "${YELLOW}Install Python latest version? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'y' 'n'
      )"
      if [[ "$input" == 'y' ]]; then
        aurs+=('python')
      fi

      if is_not_empty "${aurs[@]}"; then
        install_aur "${aurs[@]}"
        echo "${GREEN}Finished.$END"
      fi
      goto_development
      ;;
    b) main ;;
    q) quit ;;
  esac
}

goto_development
