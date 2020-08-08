#!/bin/bash -xe

# create data directories
DIRS=(
    "$USBHELPER_ROOT/userdata"
    "$USBHELPER_ROOT/downloads"
    "$USBHELPER_ROOT/downloads/UNPACKED"
)
mkdir -p "${DIRS[@]}"
chown user:user "${DIRS[@]}"

# copy initial config
if [ ! -f "$USBHELPER_ROOT/userdata/user.config" ]; then
    cp "$USBHELPER_ROOT/usbhelper.config" "$USBHELPER_ROOT/userdata/user.config"
    chown user:user "$USBHELPER_ROOT/userdata/user.config"
fi

su user -c "/entrypoint.sh"
