#!/bin/bash

source "$(dirname "$0")/../.base.sh"
set -e

echo
echo "${BOLD}Install Java programming language:$END"

packages=()
aurs=()

# Version 8

echo "${YELLOW}Install OpenJDK 8? (${UNDERLINE}A${END}${YELLOW}nd JavaFX/${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read -r input

if [[ $input == 'A' ]] || [[ $input == 'a' ]]; then
  packages+=(jdk8-openjdk openjdk8-doc openjdk8-src)
  aurs+=(java8-openjfx java8-openjfx-doc java8-openjfx-src)
elif [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  packages+=(jdk8-openjdk openjdk8-doc openjdk8-src)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

# Version 11

echo "${YELLOW}Install OpenJDK 11? (${UNDERLINE}A${END}${YELLOW}nd JavaFX/${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read -r input

if [[ $input == 'A' ]] || [[ $input == 'a' ]]; then
  packages+=(jdk11-openjdk openjdk11-doc openjdk11-src)
  aurs+=(java11-openjfx java11-openjfx-doc java11-openjfx-src)
elif [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  packages+=(jdk11-openjdk openjdk11-doc openjdk11-src)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

# Version 17

echo "${YELLOW}Install OpenJDK 17? (${UNDERLINE}A${END}${YELLOW}nd JavaFX/${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read -r input

if [[ $input == 'A' ]] || [[ $input == 'a' ]]; then
  packages+=(jdk17-openjdk openjdk17-doc openjdk17-src)
  aurs+=(java17-openjfx java17-openjfx-doc java17-openjfx-src)
elif [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  packages+=(jdk17-openjdk openjdk17-doc openjdk17-src)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

# Proceed

echo "${GREEN}Installing...$END"

install "${packages[@]}"
install_aur "${aurs[@]}"

echo 'Goodbye!'
echo

xdg-open 'https://wiki.archlinux.org/title/Java'
exit 0
