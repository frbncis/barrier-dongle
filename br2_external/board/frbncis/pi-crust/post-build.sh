#!/bin/sh

set -u
set -e

# Load Wifi Module
if [ -e ${TARGET_DIR}/etc/inittab ]; then
  grep -qE '.*brcmfmac.*' ${TARGET_DIR}/etc/inittab || \
    sed -i '/\/etc\/hostname/a\
::sysinit:\/sbin\/modprobe brcmfmac # WiFi driver' ${TARGET_DIR}/etc/inittab
fi

mkdir -p ${TARGET_DIR}/boot  ${TARGET_DIR}/data

# Mount boot partition as readonly
if [ -e ${TARGET_DIR}/etc/fstab ]; then
  grep -qE '^/dev/mmcblk0p1.*' ${TARGET_DIR}/etc/fstab || \
    echo '/dev/mmcblk0p1  /boot           auto    ro              0       0' | tee -a ${TARGET_DIR}/etc/fstab

  grep -qE '^/dev/mmcblk0p3.*' ${TARGET_DIR}/etc/fstab || \
    echo '/dev/mmcblk0p3  /data           auto    rw              0       0' | tee -a ${TARGET_DIR}/etc/fstab

fi
