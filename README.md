# docker-usbhelper
Docker image with [USBHelperLauncher](https://github.com/FailedShack/USBHelperLauncher) running in Wine, based on [shiftinv/wine-dotnet:staging-48-vnc](https://github.com/shiftinv/docker-wine#tags)


## Usage
- Download the [docker-compose.yml](https://github.com/arcticdiv/docker-usbhelper/blob/master/docker-compose.yml) file and run `docker-compose up`\
  _or_
- Run
    ```
    docker run -it \
        --name "usbhelper" \
        -v "$(pwd)/data/userdata:/home/user/usbhelper/userdata" \
        -v "$(pwd)/data/downloads:/home/user/usbhelper/downloads" \
        -p "127.0.0.1:5901:5901" \
        -p "127.0.0.1:8081:8081" \
        arcticdiv/usbhelper:latest
    ```

Optionally you may set a password for the VNC connection by setting the `VNCPASSWD` environment variable accordingly, but since the ports are only bound to `localhost` by default, it isn't required.\
Once started, navigate to `localhost:8081` with a web browser, or connect to `localhost:5901` with a VNC client.

## Building
If you want to build the docker image yourself, just run `make build`.\
Currently (until a new version of the launcher is released), you also need to add the `USBHelperLauncher.zip` file from [this][1] run to the build directory, as the latest release of the launcher isn't compatible yet.

[1]: https://github.com/shiftinv/USBHelperLauncher/actions/runs/208772821
