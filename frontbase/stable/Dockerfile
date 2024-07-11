FROM nginx:stable

ENV TZ=Asia/Shanghai

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
        procps \
        tar \
        telnet \
        unzip \
        vim \
        wget; \
    apt-get upgrade -y --no-install-recommends; \
    rm -rf /var/lib/apt/lists/*; \
    cp /etc/apt/sources.list /etc/apt/sources.list.bak; \
    sed -i "s@http://ftp.debian.org@https://repo.huaweicloud.com@g" /etc/apt/sources.list; \
    sed -i "s@http://security.debian.org@https://repo.huaweicloud.com@g" /etc/apt/sources.list

ADD default.conf /etc/nginx/conf.d/default.conf
