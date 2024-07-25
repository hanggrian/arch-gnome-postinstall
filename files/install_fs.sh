#!/bin/bash

source "$(dirname "$0")/../.base.sh"
set -e

echo
echo "${BOLD}Install various file systems:$END"

packages=()
aurs=()

# In-tree file systems

echo "${YELLOW}Apply Bcachefs? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read -r input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  packages+=(bcachefs-tools)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

echo "${YELLOW}Apply Btfrs? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read -r input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  packages+=(btrfs-progs)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

echo "${YELLOW}Apply VFAT? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read -r input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  packages+=(dosfstools)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

echo "${YELLOW}Apply ExFAT? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read -r input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  packages+=(exfatprogs)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

echo "${YELLOW}Apply F2FS? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read -r input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  packages+=(f2fs-tools)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

echo "${YELLOW}Apply ext3 and ext4? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read -r input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  packages+=(e2fsprogs)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

echo "${YELLOW}Apply HFS and HFS+? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read -r input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  aurs+=(hfsprogs)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

echo "${YELLOW}Apply JFS? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read -r input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  packages+=(jfsutils)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

echo "${YELLOW}Apply NILFS2? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read -r input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  packages+=(nilfs-utils)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

echo "${YELLOW}Apply NTFS? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read -r input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  packages+=(ntfs-3g)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

echo "${YELLOW}Apply ReiserFS? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read -r input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  packages+=(reiserfsprogs)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

echo "${YELLOW}Apply XFS? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read -r input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  packages+=(xfsprogs)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

# Out-of-tree file systems

echo "${YELLOW}Apply APFS? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read -r input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  check_dkms
  aurs+=(linux-apfs-rw-dkms-git apfsprogs-git)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

echo "${YELLOW}Apply Reiser4? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read -r input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  aurs+=(reiser4progs)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

echo "${YELLOW}Apply ZFS? (${UNDERLINE}Y${END}${YELLOW}es/${UNDERLINE}N${END}${YELLOW}o)$END"
read -r input

if [[ $input == 'Y' ]] || [[ $input == 'y' ]]; then
  check_dkms
  aurs+=(zfs-dkms zfs-utils)
elif [[ $input != 'N' ]] && [[ $input != 'n' ]]; then
  die 'Unknown input.'
fi

# Proceed

echo "${GREEN}Installing...$END"

install "${packages[@]}"
install_aur "${aurs[@]}"

echo 'Goodbye!'
echo

xdg-open 'https://wiki.archlinux.org/title/File_systems'
exit 0
