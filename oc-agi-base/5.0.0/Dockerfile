FROM onecontract/javabase:temurin_17-jdk-noble

RUN set -eux; \
    ARCH="$(dpkg --print-architecture)"; \
    mv /etc/apt/sources.list.d/ubuntu.sources.bak /etc/apt/sources.list.d/ubuntu.sources; \
    apt update; \
    apt install -y --no-install-recommends \
        ant \
        build-essential \
        cmake \
        python3 \
        python3-distutils \
        python3-numpy \
        g++; \
    ln -snf /usr/share/ant/bin/ant /bin/ant; \
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
    cp /etc/apt/sources.list.d/ubuntu.sources /etc/apt/sources.list.d/ubuntu.sources.bak; \
    sed -i "s@http://.*archive.ubuntu.com@https://mirrors.huaweicloud.com@g" /etc/apt/sources.list.d/ubuntu.sources; \
    sed -i "s@http://.*security.ubuntu.com@https://mirrors.huaweicloud.com@g" /etc/apt/sources.list.d/ubuntu.sources; \
    sed -i "s@http://.*ports.ubuntu.com@https://mirrors.huaweicloud.com@g" /etc/apt/sources.list.d/ubuntu.sources; \
    rm -rf /var/lib/apt/lists/*
