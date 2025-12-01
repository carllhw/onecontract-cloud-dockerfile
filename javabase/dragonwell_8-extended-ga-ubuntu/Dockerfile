FROM alibabadragonwell/dragonwell:8-extended-ga-ubuntu

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
    case "${TARGETPLATFORM}" in \
        "linux/amd64") \
          sed -i "s@http://.*archive.ubuntu.com@https://repo.huaweicloud.com@g" /etc/apt/sources.list; \
          sed -i "s@http://.*security.ubuntu.com@https://repo.huaweicloud.com@g" /etc/apt/sources.list; \
          ;; \
        "linux/arm64") \
          wget -qO /etc/apt/sources.list https://mirrors.huaweicloud.com/artifactory/os-conf/ubuntu-ports/Ubuntu-Ports-focal.list; \
          ;; \
        *) \
          echo "Unsupported platform: ${TARGETPLATFORM}"; \
          exit 1; \
          ;; \
    esac

ENTRYPOINT ["/docker-entrypoint.sh"]

