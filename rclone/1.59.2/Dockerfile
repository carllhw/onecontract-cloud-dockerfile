FROM ubuntu:20.04

ARG RCLONE_VERSION="v1.59.2"

ENV TZ="Asia/Shanghai"

RUN set -eux; \
    ARCH="$(dpkg --print-architecture)"; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        dnsutils \
        netcat \
        procps \
        tar \
        unzip \
        vim \
        wget; \
    rm -rf /var/lib/apt/lists/*; \
# rclone
    curl -LfsSo "/tmp/rclone-${RCLONE_VERSION}-linux-${ARCH}.zip" "https://downloads.rclone.org/${RCLONE_VERSION}/rclone-${RCLONE_VERSION}-linux-${ARCH}.zip"; \
    unzip -q /tmp/rclone-${RCLONE_VERSION}-linux-${ARCH}.zip -d /tmp; \
    cp /tmp/rclone-${RCLONE_VERSION}-linux-${ARCH}/rclone /usr/local/bin/

RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak; \
    sed -i 's http://.*.ubuntu.com http://mirrors.aliyun.com g' /etc/apt/sources.list
