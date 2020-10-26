* Initialize a build output folder
```bash
make O=$PWD BR2_EXTERNAL=~/git/pi-crust-os/br2_external -C ../buildroot-2020.02.7 pi_crust_ext_sdk_defconfig
```

* Save kernel configuration
```bash
make linux-update-config
```

* Save the build definition
```bash
make savedefconfig BR2_DEFCONFIG=~/git/pi-crust-os/br2_external/configs/pi_crust_ext_sdk_defconfig
```
