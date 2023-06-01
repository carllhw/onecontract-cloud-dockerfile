FROM onecontract/javabase:dragonwell_8.15.16-extended-ga-ubuntu

RUN set -eux; \
    ARCH="$(dpkg --print-architecture)"; \
    mv /etc/apt/sources.list.bak /etc/apt/sources.list; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        ant \
        build-essential \
        cmake \
        g++; \
    wget -qO opencv.zip \
        https://github.com/opencv/opencv/archive/4.x.zip; \
    wget -qO opencv_contrib.zip \
        https://github.com/opencv/opencv_contrib/archive/4.x.zip; \
    unzip opencv.zip; \
    unzip opencv_contrib.zip; \
    rm -f opencv.zip; \
    rm -f opencv_contrib.zip; \
    mkdir -p /opencv-4.x/build && cd /opencv-4.x/build; \
    cmake -D BUILD_TESTS=OFF \
        -DOPENCV_EXTRA_MODULES_PATH=/opencv_contrib-4.x/modules/wechat_qrcode \
        -D BUILD_opencv_superres=OFF \
        -D BUILD_opencv_ts=OFF \
        -D BUILD_opencv_gpu=OFF  \
        -D BUILD_opencv_apps=OFF \
        -D BUILD_opencv_video=OFF \
        -D BUILD_opencv_videostab=OFF \
        -D BUILD_opencv_videoio=OFF \
        -D BUILD_opencv_gpu=OFF \
        -D BUILD_opencv_ml=OFF \
        -D BUILD_opencv_stitching=OFF \
        -D BUILD_opencv_highgui=OFF \
        -D BUILD_opencv_gapi=OFF \
        /opencv-4.x; \
    make -j8; \
    make install; \
    cp /etc/apt/sources.list /etc/apt/sources.list.bak; \
    sed -i 's http://.*.ubuntu.com http://mirrors.aliyun.com g' /etc/apt/sources.list; \
    rm -rf /var/lib/apt/lists/*
