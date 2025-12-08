FROM eclipse-temurin:17-jdk-noble

ENV TZ="Asia/Shanghai"

ARG TARGETPLATFORM

RUN set -eux; \
    ARCH="$(dpkg --print-architecture)"; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        dnsutils \
        fonts-wqy-zenhei \
        fonts-wqy-microhei \
        fonts-arphic-ukai \
        fonts-arphic-uming \
        gnupg2 \
        iputils-ping \
        lsof \
        netcat-openbsd \
        net-tools \
        openssh-client \
        procps \
        tar \
        telnet \
        unzip \
        vim \
        wget; \
    mkdir /docker-entrypoint.d; \
    rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /
COPY 10-java-opts.envsh /docker-entrypoint.d
RUN set -eux; \
    chmod +x /docker-entrypoint.sh; \
    chmod +x /docker-entrypoint.d/*; \
    cp /etc/apt/sources.list.d/ubuntu.sources /etc/apt/sources.list.d/ubuntu.sources.bak; \
    sed -i "s@http://.*archive.ubuntu.com@https://mirrors.huaweicloud.com@g" /etc/apt/sources.list.d/ubuntu.sources; \
    sed -i "s@http://.*security.ubuntu.com@https://mirrors.huaweicloud.com@g" /etc/apt/sources.list.d/ubuntu.sources

ENTRYPOINT ["/docker-entrypoint.sh"]
