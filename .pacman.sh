#!/bin/bash

echo

packages=()

# Pacman Contrib

if [[ "$(
  get_input \
    "${YELLOW}Apply Pacman Contrib? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
      'y' 'n'
    )" == 'y'
  ]]; then
  packages+=('pacman-contrib')
fi

# Reflector

if [[ "$(
  get_input \
    "${YELLOW}Apply Reflector? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
      'y' 'n'
    )" == 'y'
  ]]; then
  packages+=('reflector')
fi

# Proceed

echo "${GREEN}Installing...$END"

install "${packages[@]}"
