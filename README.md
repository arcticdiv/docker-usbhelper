# docker-usbhelper
Docker image with [USBHelperLauncher](https://github.com/FailedShack/USBHelperLauncher) running in Wine, based on [shiftinv/wine-dotnet:staging-48-vnc](https://github.com/shiftinv/docker-wine#tags)

***[Currently does not work right out of the box, as the latest launcher release isn't compatible yet.
To work around this, either build the `master` branch of the launcher yourself or download the artifact [here](https://github.com/shiftinv/USBHelperLauncher/actions/runs/208772821), and replace the files inside the image.]***

## Usage
- Download the [docker-compose.yml](https://github.com/arcticdiv/docker-usbhelper/blob/master/docker-compose.yml) file and run `docker-compose up`  
  _or_
- Run
    ```
    docker run -it \
        --name "usbhelper" \
        -v "$(pwd)/data/userdata:/home/user/usbhelper/userdata" \
        -v "$(pwd)/data/downloads:/home/user/usbhelper/downloads" \
        -p "127.0.0.1:5901:5901" \
        -e VNCPASSWD="<unset>" \
        arcticdiv/usbhelper:latest
    ```

In both cases, replace `<unset>` with a new 8-character VNC password before starting.  
Once started, you can connect to `127.0.0.1:5901` with a VNC client.
