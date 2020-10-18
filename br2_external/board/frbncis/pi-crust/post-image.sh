#!/bin/bash

set -e

BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"
GENIMAGE_CFG="${BOARD_DIR}/genimage-${BOARD_NAME}.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

for arg in "$@"
do
	case "${arg}" in
    --disable-splash)
    if ! grep -qE '^disable_splash=' "${BINARIES_DIR}/rpi-firmware/config.txt"; then
      echo "Disabling color test on boot."
      cat << __EOF__ >> "${BINARIES_DIR}/rpi-firmware/config.txt"

# Disable color test
disable_splash=1
__EOF__
    fi
    ;;
	esac

# TODO: Parse post-image script arguments to set cmdline.txt
echo "root=/dev/mmcblk0p2 rootwait console=tty1 logo.nologo" > "${BINARIES_DIR}/rpi-firmware/cmdline.txt"

done
