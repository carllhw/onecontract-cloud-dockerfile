FROM dragonwell-registry.cn-hangzhou.cr.aliyuncs.com/dragonwell/dragonwell:8.16.17-extended-ga-ubuntu

ENV TZ="Asia/Shanghai"

RUN set -eux; \
    ARCH="$(dpkg --print-architecture)"; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        dnsutils \
        gnupg2 \
        iputils-ping \
        lsof \
        netcat \
        net-tools \
        openssh-client \
        percona-toolkit \
        procps \
        tar \
        telnet \
        unzip \
        vim \
        wget; \
# percona-toolkit
    wget -qO /usr/local/bin/pt-archiver "https://www.percona.com/get/pt-archiver"; \
    chmod +x /usr/local/bin/pt-archiver; \
    mkdir /docker-entrypoint.d; \
    rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /
COPY 10-java-opts.envsh /docker-entrypoint.d
RUN set -eux; \
    chmod +x /docker-entrypoint.sh; \
    chmod +x /docker-entrypoint.d/*; \
    cp /etc/apt/sources.list /etc/apt/sources.list.bak; \
    sed -i "s@http://.*archive.ubuntu.com@https://repo.huaweicloud.com@g" /etc/apt/sources.list; \
    sed -i "s@http://.*security.ubuntu.com@https://repo.huaweicloud.com@g" /etc/apt/sources.list

ENTRYPOINT ["/docker-entrypoint.sh"]

