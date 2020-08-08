#!/bin/bash -xe
set -o pipefail

_install_zip() {
    wget "$1" -O .tmp_download.zip
    unzip -o .tmp_download.zip
    rm .tmp_download.zip
}

check_set() {
    val="${!1}"
    [ -n "$val" ] || { echo "\$$1 is not set" >&2; exit 1; }
}

check_exists() {
    [ -f "$1" ] || { echo "Something went wrong, \"$1\" wasn't found after extraction" >&2; exit 1; }
}


check_set USBHELPER_VERSION
check_set LAUNCHER_VERSION

USBHELPER_URL="https://archive.org/download/WiiUUSBHelper/Wii%20U%20USB%20Helper%20$USBHELPER_VERSION.zip"
[ "$LAUNCHER_VERSION" == "latest" ] || LAUNCHER_VERSION="tags/$LAUNCHER_VERSION"
LAUNCHER_URL=$(curl -fsSL "https://api.github.com/repos/FailedShack/USBHelperLauncher/releases/$LAUNCHER_VERSION" | jq -r '.assets[0].browser_download_url')

_install_zip "$USBHELPER_URL"
_install_zip "$LAUNCHER_URL"

check_exists "WiiU_USB_Helper.exe"
check_exists "USBHelperLauncher.exe"
