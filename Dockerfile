ARG BASE_IMAGE=shiftinv/wine-dotnet:staging-48-vnc

# temporary workaround as latest launcher release isn't compatible yet
#   the .zip is the artifact from this run: https://github.com/shiftinv/USBHelperLauncher/actions/runs/208772821
FROM $BASE_IMAGE
COPY USBHelperLauncher.zip /tmp/USBHelperLauncher.zip
RUN unzip /tmp/USBHelperLauncher.zip -d /tmp/USBHelperLauncher


FROM $BASE_IMAGE

# install dependencies
USER root
RUN $APT_CMD update \
 && $APT_CMD install -y curl jq unzip \
 && apt-get clean \
 && find /var/lib/apt/lists/ /tmp/ /var/tmp/ -mindepth 1 -maxdepth 1 -exec rm -rf "{}" +
USER user

# disable gecko popup
ENV WINEDLLOVERRIDES="mshtml=d;$WINEDLLOVERRIDES"

# install USB Helper
ARG USBHELPER_VERSION=0.6.1.653
ARG LAUNCHER_VERSION=latest
ENV USBHELPER_ROOT=/home/user/usbhelper
# RUN mkdir $USBHELPER_ROOT
COPY --from=0 --chown=user:user /tmp/USBHelperLauncher $USBHELPER_ROOT
WORKDIR $USBHELPER_ROOT

COPY scripts/install_usbhelper.sh /scripts/install_usbhelper.sh
RUN /scripts/install_usbhelper.sh

# add desktop icon
COPY --chown=user:user files/WiiUUSBHelper.desktop /home/user/Desktop/
COPY --chown=user:user files/USBHelperLauncher.png "$USBHELPER_ROOT/"

# copy initial config, create link for launcher config
COPY --chown=user:user files/user.config "$USBHELPER_ROOT/usbhelper.config"
RUN ln -s "./userdata/conf.json" "$USBHELPER_ROOT/conf.json"

VOLUME ["$USBHELPER_ROOT/userdata", "$USBHELPER_ROOT/downloads"]

# root is required for fixing volume permissions, entrypoint script drops privileges
USER root
COPY entrypoint.sh /usbhelper-entrypoint.sh
ENTRYPOINT /usbhelper-entrypoint.sh
