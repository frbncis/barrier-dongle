#!/bin/sh

set -u
set -e

# Load Wifi Module
if [ -e ${TARGET_DIR}/etc/inittab ]; then
  grep -qE '.*brcmfmac.*' ${TARGET_DIR}/etc/inittab || \
    sed -i '/\/etc\/hostname/a\
::sysinit:\/sbin\/modprobe brcmfmac # WiFi driver' ${TARGET_DIR}/etc/inittab
fi

