#!/bin/bash
set -x

BUILDROOT_CACHE=$PWD/cache
BUILDROOT="buildroot"

BUILDROOT_LOCKFILE=.buildroot.lock
BUILDROOT_CURRENT_LOCKFILE=.buildroot.current.lock

if [ -z $BUILDROOT_VERSION ]; then
  if [ -e $1 ]; then
      echo "Sourcing desired Buildroot version from $BUILDROOT_LOCKFILE"
      BUILDROOT_VERSION=$(cat .buildroot.lock)
  else
      echo "Sourcing desired Buildroot version from argument"
      BUILDROOT_VERSION=$1
  fi 
fi

echo "Desired Buildroot version is $BUILDROOT_VERSION"

BUILDROOT_DOWNLOAD_URL="https://buildroot.org/downloads/buildroot-$BUILDROOT_VERSION.tar.gz"

if [ ! -e $BUILDROOT_CACHE ]; then
    echo "Creating cache folder..."
    mkdir -p $BUILDROOT_CACHE
fi

if [ ! -e $BUILDROOT_CACHE/$BUILDROOT_VERSION.tar.gz ]; then
    echo "Downloading Buildroot $BUILDROOT_VERSION from $BUILDROOT_DOWNLOAD_URL..."
    curl $BUILDROOT_DOWNLOAD_URL -o $BUILDROOT_CACHE/$BUILDROOT_VERSION.tar.gz 
fi

if [ ! -e $BUILDROOT_CURRENT_LOCKFILE ]; then
    echo "Current Buildroot version in directory is not specified."
    echo 0 > $BUILDROOT_CURRENT_LOCKFILE
else
	echo "Current Buildroot version in directory is $(cat $BUILDROOT_CURRENT_LOCKFILE)"
fi

# Check the lock file to see what version of Buildroot is currently
# configured.
if [ ! -e $BUILDROOT ] || ! grep -q "$BUILDROOT_VERSION" "$BUILDROOT_CURRENT_LOCKFILE" || ! grep -q "$BUILDROOT_VERSION" "$BUILDROOT_LOCKFILE"; then
    echo "Initializing Buildroot directory to $BUILDROOT_VERSION..."

    rm -rf Buildroot
    tar xf $BUILDROOT_CACHE/$BUILDROOT_VERSION.tar.gz -C .
    mv buildroot-$BUILDROOT_VERSION $BUILDROOT

    echo $BUILDROOT_VERSION > $BUILDROOT_LOCKFILE
    echo $BUILDROOT_VERSION > $BUILDROOT_CURRENT_LOCKFILE

    rm -rf build
    mkdir build
    cd build
    make O=$PWD BR2_EXTERNAL=../br2_external -C ../buildroot pi_crust_ext_sdk_defconfig
fi

echo "Done!"
