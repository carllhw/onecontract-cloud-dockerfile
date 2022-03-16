FROM debian:buster

ARG RCLONE_VERSION="v1.57.0"
ARG TINI_VERSION="v0.19.0"

ENV TZ="Asia/Shanghai"

RUN apt update; \
    apt install -y --no-install-recommends \
        unzip \
        wget; \
    apt-get upgrade -y --no-install-recommends; \
    rm -rf /var/lib/apt/lists/*; \
    wget -qO "/tmp/rclone-${RCLONE_VERSION}-linux-amd64.zip" "https://downloads.rclone.org/${RCLONE_VERSION}/rclone-${RCLONE_VERSION}-linux-amd64.zip"; \
    unzip -q /tmp/rclone-${RCLONE_VERSION}-linux-amd64.zip -d /tmp; \
    cp /tmp/rclone-${RCLONE_VERSION}-linux-amd64/rclone /usr/local/bin/

RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak; \
    sed -i 's http://.*.debian.org http://mirrors.aliyun.com g' /etc/apt/sources.list
