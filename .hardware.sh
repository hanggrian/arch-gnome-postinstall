#!/bin/bash

echo

packages=()
aurs=()

# CPU

input="$(
  get_input \
    "${YELLOW}Apply microcode? \
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

# GPU

input="$(
  get_input \
    "${YELLOW}Apply graphic drivers? \
(${UNDERLINE}I${END}${YELLOW}ntel/\
${UNDERLINE}A${END}${YELLOW}MD/\
${UNDERLINE}N${END}${YELLOW}VIDIA/\
${UNDERLINE}S${END}${YELLOW}kip)$END" \
    'i' 'a' 'n' 's'
)"
if [[ "$input" == 'i' ]]; then
  input="$(
    get_input \
      "${YELLOW}What is the CPU generation? \
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
elif [[ "$input" == 'a' ]]; then
  packages+=('mesa' 'libva-mesa-driver' 'mesa-vdpau' 'vulkan-radeon')
elif [[ "$input" == 'n' ]]; then
  input="$(
    get_input \
      "${YELLOW}What is the GPU generation? \
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
fi

# Proceed

echo "${GREEN}Installing...$END"

install "${packages[@]}"
install_aur "${aurs[@]}"
