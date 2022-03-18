FROM ubuntu:20.04

ARG RCLONE_VERSION="v1.57.0"
ARG TINI_VERSION="v0.19.0"

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
        wget; \
    apt-get upgrade -y --no-install-recommends; \
    rm -rf /var/lib/apt/lists/*; \
# tini
    curl -LfsSo "tini-static-${ARCH}" \
       "https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-static-${ARCH}"; \
    curl -LfsSo "tini-static-${ARCH}.sha256sum" \
       "https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-static-${ARCH}.sha256sum"; \
    sha256sum --strict --check <"tini-static-${ARCH}.sha256sum"; \
    rm -r "tini-static-${ARCH}.sha256sum"; \
    mv "tini-static-${ARCH}" /usr/bin/tini; \
    chmod +x /usr/bin/tini; \
    tini --version; \
# rclone
    curl -LfsSo "/tmp/rclone-${RCLONE_VERSION}-linux-${ARCH}.zip" "https://downloads.rclone.org/${RCLONE_VERSION}/rclone-${RCLONE_VERSION}-linux-${ARCH}.zip"; \
    unzip -q /tmp/rclone-${RCLONE_VERSION}-linux-${ARCH}.zip -d /tmp; \
    cp /tmp/rclone-${RCLONE_VERSION}-linux-${ARCH}/rclone /usr/local/bin/

RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak; \
    sed -i 's http://.*.debian.org http://mirrors.aliyun.com g' /etc/apt/sources.list

ENTRYPOINT ["tini", "--"]
