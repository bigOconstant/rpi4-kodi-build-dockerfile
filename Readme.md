# Raspberry pi Kodi Dockerfile

This docker file is meant to build popocornmix's latest raspberry pi branch of kodi for testing.

## Build

docker build -t kodi .

## Get Executable off container

1. Run container `docker run -it /bin/bash`
2. In a seperate terminal get id of container. `docker ps -a`
3. run copy command as sudo `docker cp <containerid>:/kodi-build /kodi-build
4. Run kodi from /kodi-build directory `/kodi-build/kodi-x11`

