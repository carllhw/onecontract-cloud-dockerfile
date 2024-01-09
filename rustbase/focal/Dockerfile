FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ="Asia/Shanghai"

RUN set -eux; \
    ARCH="$(dpkg --print-architecture)"; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        binutils \
        ca-certificates \
        curl \
        dnsutils \
        fontconfig \
        graphviz \
        iputils-ping \
        libjemalloc-dev \
        libssl-dev \
        locales \
        lsof \
        netcat \
        net-tools \
        openssh-client \
        pkg-config \
        procps \
        tar \
        telnet \
        tzdata \
        unzip \
        vim \
        wget; \
    apt-get upgrade -y --no-install-recommends; \
    mkdir /docker-entrypoint.d; \
    rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /
RUN set -eux; \
    chmod +x /docker-entrypoint.sh; \
    cp /etc/apt/sources.list /etc/apt/sources.list.bak; \
    sed -i 's http://.*.ubuntu.com http://mirrors.aliyun.com g' /etc/apt/sources.list

ENTRYPOINT ["/docker-entrypoint.sh"]
