# barrier-dongle

[![Build Status](https://dev.azure.com/frbncis/barrier-hid-dongle/_apis/build/status/frbncis.barrier-dongle?branchName=master)](https://dev.azure.com/frbncis/barrier-hid-dongle/_build/latest?definitionId=2&branchName=master)

This is an evolution of the [pi-crust](https://github.com/frbncis/pi-crust), an attempt at building a hardware `barrier` client that emits mouse and keyboard movements to clients over USB HID.

This is packaged as an SD card image for the Raspberry Pi Zero W that boots into a stripped down embedded Linux environment. Startup takes about ~12 seconds compared to the 30+ seconds with Raspberry Pi OS. ConfigFS setup is taken care of.

## Installing
* Grab a zipped copy of the image from the [releases](https://github.com/frbncis/barrier-dongle/releases) page.
* Unzip and burn the image to a microSD card. You can use the official [Raspberry Pi Image](https://www.raspberrypi.com/software/) or `dd`.
  * If you're re-burning the image, you *should* be able to use something similar to `update-sdcard.sh $PATH_TO_IMAGE_ZIP /dev/mmcblk0` to overwrite the OS partition and preserve the data partition that contains the `wpa_supplicant.conf` and `barrierc.txt` files (see below). Use at your own risk.

## Configuring

The SD card contains 3 partitions. The third partition is a ~34 MB "data" partition where you can place configuration files for `barrierc` and wifi. This partition wll be initially empty.

You will need to create two files as noted below.

* Sample `wpa_supplicant.conf` for wifi settings:

```
ctrl_interface=/var/run/wpa_supplicant
ap_scan=1

network={
   ssid="my-wireless-network"
   psk="my-wireless-network-passphrase"
}
```

* Sample `barrierc.txt` for barrierc startup arguments:
  * Set `--display-width` and `--display-height` to your client's resolution.
```
BARRIERC_ARGS="--name barrier-hid-dongle --display-width 1920 --display-height 1200 --keyboard /dev/hidg0 --mouse /dev/hidg1 <barriers-server-name>"
```
