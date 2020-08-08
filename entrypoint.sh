#!/bin/bash -xe

# create data directories
DIRS=(
    "$USBHELPER_ROOT/userdata"
    "$USBHELPER_ROOT/downloads"
    "$USBHELPER_ROOT/downloads/UNPACKED"
)
mkdir -p "${DIRS[@]}"
chown user:user "${DIRS[@]}"

su user -c bash <<EOF
    set -xe
    # initialize launcher config
    [ -f "$USBHELPER_ROOT/userdata/conf.json" ] || echo "{}" > "$USBHELPER_ROOT/userdata/conf.json"

    # copy initial config
    [ -f "$USBHELPER_ROOT/userdata/user.config" ] || cp "$USBHELPER_ROOT/usbhelper.config" "$USBHELPER_ROOT/userdata/user.config"

    /entrypoint.sh
EOF
