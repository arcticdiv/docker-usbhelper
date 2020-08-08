#!/bin/bash -xe

# fix volume permissions
chown user:user "$USBHELPER_ROOT/userdata" "$USBHELPER_ROOT/downloads"

# copy initial config
if [ ! -f "$USBHELPER_ROOT/userdata" ]; then
    cp "$USBHELPER_ROOT/usbhelper.config" "$USBHELPER_ROOT/userdata/user.config"
    chown user:user "$USBHELPER_ROOT/userdata/user.config"
fi

su user -c "/entrypoint.sh"
