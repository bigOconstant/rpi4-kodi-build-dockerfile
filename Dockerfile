FROM debian:latest

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install debhelper autoconf automake autopoint gettext autotools-dev cmake curl default-jre doxygen gawk gcc gdc gperf libasound2-dev libass-dev libavahi-client-dev libavahi-common-dev libbluetooth-dev libbluray-dev libbz2-dev libcdio-dev libp8-platform-dev libcrossguid-dev libcurl4-openssl-dev libcwiid-dev libfstrcmp-dev libgcrypt-dev libgif-dev libgles2-mesa-dev libgl1-mesa-dev libglu1-mesa-dev libgnutls28-dev libgpg-error-dev libiso9660-dev libjpeg-dev liblcms2-dev libltdl-dev liblzo2-dev libmicrohttpd-dev libnfs-dev libogg-dev libpcre3-dev libplist-dev libpng-dev libpulse-dev libsmbclient-dev libsqlite3-dev libssl-dev libtag1-dev libtiff5-dev libtinyxml-dev libtool libudev-dev libva-dev libvdpau-dev libvorbis-dev libxmu-dev libxrandr-dev libxslt1-dev libxt-dev lsb-release python3-dev python3-pil rapidjson-dev swig  unzip uuid-dev yasm zip zlib1g-dev libmariadb-dev ccache clang-format liblirc-dev libsndio-dev libcap-dev libcec-dev libavahi-core-dev libunistring-dev libgbm-dev libinput-dev libxkbcommon-dev -y

RUN apt-get install git -y

WORKDIR /

RUN git clone -b gbm --depth 1 https://github.com/popcornmix/xbmc.git kodi

WORKDIR /kodi

RUN make -C tools/depends/target/crossguid PREFIX=/usr/local

RUN make -C tools/depends/target/flatbuffers PREFIX=/usr/local

RUN make -C tools/depends/target/libfmt PREFIX=/usr/local

RUN make -C tools/depends/target/libspdlog PREFIX=/usr/local

WORKDIR /kodi-build

RUN cmake ../kodi -DCMAKE_INSTALL_PREFIX=/usr/local -DCORE_PLATFORM_NAME=gbm -DAPP_RENDER_SYSTEM=gles -DENABLE_INTERNAL_FMT=ON -DENABLE_INTERNAL_FLATBUFFERS=ON -DENABLE_TESTING=OFF -DENABLE_INTERNAL_SPDLOG=ON

RUN cp -r /usr/include/libdrm /usr/include/drm
RUN cmake --build . -- VERBOSE=1 -j$(getconf _NPROCESSORS_ONLN)
