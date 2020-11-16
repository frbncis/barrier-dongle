#!/bin/bash
set -x
unzip -p $1 | dd of=$2 count=270336 status=progress conv=fsync;sync
