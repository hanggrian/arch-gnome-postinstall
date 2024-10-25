#!/bin/bash

goto_security() {
  echo
  echo "${BOLD}Security:$END"
  echo '1. MAC'
  echo '2. Firewalld'
  echo '3. ClamAV'

  case "$(
    get_input \
      "${YELLOW}What to install? \
(1-3/\
$YELLOW${UNDERLINE}B${END}${YELLOW}ack/\
$YELLOW${UNDERLINE}Q${END}${YELLOW}uit)$END" \
      '1' '2' '3' 'b' 'q'
  )" in
    1)
      # https://wiki.archlinux.org/title/Security#Mandatory_access_control
      packages=()
      services=()
      is_selinux=false

      input="$(
        get_input \
          "${YELLOW}Install mandatory access control? \
(${UNDERLINE}A${END}${YELLOW}ppArmor/\
${UNDERLINE}S${END}${YELLOW}ELinux/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'a' 's' 'n'
      )"
      if [[ "$input" == 'a' ]]; then
        packages+=('apparmor')
        services+=('apparmor.service')
      elif [[ "$input" == 's' ]]; then
        is_selinux=true

        git clone https://github.com/archlinuxhardened/selinux.git
        chmod -R +x selinux
        pushd selinux || exit
        ./recv_gpg_keys.sh
        ./build_and_install_all.sh
        popd || exit
        rm -rf selinux
      fi

      if is_not_empty "${packages[@]}" || \
        is_not_empty "${services[@]}" || \
        "$is_selinux"; then
        install "${packages[@]}"
        enable "${services[@]}"
        echo "${GREEN}Finished.$END"
      fi
      goto_security
      ;;
    2)
      # https://wiki.archlinux.org/title/Firewalld
      packages=()
      aurs=()

      input="$(
        get_input \
          "${YELLOW}Install ClamAV? \
(${UNDERLINE}C${END}${YELLOW}LI/\
${UNDERLINE}G${END}${YELLOW}UI/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'c' 'g' 'n'
      )"
      if [[ "$input" == 'c' ]]; then
        packages+=('clamav')
      elif [[ "$input" == 'g' ]]; then
        packages+=('clamav' 'clamtk')
        aurs+=('clamtk-gnome')
      fi

      if is_not_empty "${packages[@]}" || \
        is_not_empty "${aurs[@]}"; then
        install "${packages[@]}"
        install_aur "${aurs[@]}"
        echo "${GREEN}Finished.$END"
      fi
      goto_security
      ;;
    3)
      # https://wiki.archlinux.org/title/List_of_applications/Security#Anti_malware
      packages=()
      services=()

      input="$(
        get_input \
          "${YELLOW}Install a firewall? \
(${UNDERLINE}U${END}${YELLOW}FW/\
${UNDERLINE}F${END}${YELLOW}irewalld/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
          'u' 'f' 'n'
      )"
      if [[ "$input" == 'u' ]]; then
        packages+=('ufw')
      elif [[ "$input" == 'f' ]]; then
        packages+=('firewalld')
        services+=('firewalld.service')
      fi

      if is_not_empty "${packages[@]}" || \
        is_not_empty "${services[@]}"; then
        install "${packages[@]}"
        enable "${services[@]}"
        echo "${GREEN}Finished.$END"
      fi
      goto_security
      ;;
    b) main ;;
    q) quit ;;
  esac
}

goto_security
