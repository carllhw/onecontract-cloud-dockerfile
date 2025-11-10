FROM ubuntu:24.04

ARG RCLONE_VERSION="v1.71.2"
ARG REDIS_DUMP_GO_VERSION="v0.8.2"

ENV TZ="Asia/Shanghai"

RUN set -eux; \
    apt-get update; \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        dnsutils \
        gnupg2 \
        mysql-client \
        netcat-openbsd \
        net-tools \
        openssh-client \
        procps \
        redis-tools \
        tar \
        telnet \
        tzdata \
        unzip \
        vim \
        wget \
        zip; \
    # rclone
    wget -qO "/tmp/rclone-linux-amd64.zip" "https://downloads.rclone.org/${RCLONE_VERSION}/rclone-${RCLONE_VERSION}-linux-amd64.zip"; \
    unzip -q /tmp/rclone-linux-amd64.zip -d /tmp; \
    cp /tmp/rclone-${RCLONE_VERSION}-linux-amd64/rclone /usr/local/bin/; \
    # redis-dump-go
    wget -qO "/tmp/redis-dump-go-linux-amd64.tar.gz" "https://github.com/yannh/redis-dump-go/releases/download/${REDIS_DUMP_GO_VERSION}/redis-dump-go-linux-amd64.tar.gz"; \
    tar -xzf /tmp/redis-dump-go-linux-amd64.tar.gz -C /tmp; \
    cp /tmp/redis-dump-go /usr/local/bin/; \
    # mongodb
    curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor; \
    echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-7.0.list; \
    apt-get update; \
    apt-get install -y --no-install-recommends mongodb-org-tools; \
    # postgresql
    apt-get install -y --no-install-recommends postgresql-client; \
    rm -rf /var/lib/apt/lists/*

RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak; \
    sed -i "s@http://.*archive.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list; \
    sed -i "s@http://.*security.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list
