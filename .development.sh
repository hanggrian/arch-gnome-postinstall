#!/bin/bash

echo

packages=()
services=()

# Docker

if [[ "$(
  get_input \
    "${YELLOW}Apply Docker engine? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
      'y' 'n'
    )" == 'y'
  ]]; then
  packages+=('docker')
  services+=('docker.service')
fi

# Java

if [[ "$(
  get_input \
    "${YELLOW}Apply Java 8 programming language? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
      'y' 'n'
    )" == 'y'
  ]]; then
  aurs+=('jdk8-temurin')
fi

if [[ "$(
  get_input \
    "${YELLOW}Apply Java 11 programming language? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
      'y' 'n'
    )" == 'y'
  ]]; then
  aurs+=('jdk11-temurin')
fi

if [[ "$(
  get_input \
    "${YELLOW}Apply Java 17 programming language? \
(${UNDERLINE}Y${END}${YELLOW}es/\
${UNDERLINE}N${END}${YELLOW}o)$END" \
      'y' 'n'
    )" == 'y'
  ]]; then
  aurs+=('jdk17-temurin')
fi

# Proceed

echo "${GREEN}Installing...$END"

install "${packages[@]}"
install_aur "${aurs[@]}"
enable "${services[@]}"
