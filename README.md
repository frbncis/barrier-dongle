# barrier-dongle

[![Build Status](https://dev.azure.com/frbncis/barrier-hid-dongle/_apis/build/status/frbncis.barrier-dongle?branchName=master)](https://dev.azure.com/frbncis/barrier-hid-dongle/_build/latest?definitionId=2&branchName=master)

This is an evolution of the [pi-crust](https://github.com/frbncis/pi-crust), an attempt at building a hardware `barrier` client that emits mouse and keyboard movements to clients over USB HID.

This is packaged as an SD card image for the Raspberry Pi Zero W that boots into a stripped down embedded Linux environment. Startup takes about ~12 seconds ompared to the 30+ seconds with Raspberry Pi OS. All ConfigFS are taken care of.

## Configuring

The SD card contains 3 partitions. The third partition is a ~34 MB "data" partition where you can place configuration files for `barrierc` and wifi.

### Sample `wpa_supplicant.conf` for wifi settings:

```
ctrl_interface=/var/run/wpa_supplicant
ap_scan=1

network={
   ssid="my-wireless-network"
   psk="my-wireless-network-passphrase"
}
```

### Sample `barrierc.txt` for barrierc startup arguments:

```
BARRIERC_ARGS="--name barrier-hid-dongle --display-width 1920 --display-height 1200 --keyboard /dev/hidg0 --mouse /dev/hidg1 <barriers-server-name>"
```

* Set `--display-width` and `--display-height` to your client's resolution.
