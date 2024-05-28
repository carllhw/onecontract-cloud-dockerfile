FROM mysql:8.0-debian as mysql
FROM ubuntu:22.04

ARG RCLONE_VERSION="v1.66.0"

ENV TZ="Asia/Shanghai"

COPY --from=mysql /usr/bin/mysql /usr/bin/mysql
COPY --from=mysql /usr/bin/mysqlpump /usr/bin/mysqlpump
COPY --from=mysql /usr/bin/lz4_decompress /usr/bin/lz4_decompress

RUN apt-get update; \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        dnsutils \
        gnupg2 \
        netcat \
        net-tools \
        openssh-client \
        procps \
        redis-tools; \
        tar \
        telnet \
        unzip \
        vim \
        wget; \
    rm -rf /var/lib/apt/lists/*; \
    wget -qO "/tmp/rclone-${RCLONE_VERSION}-linux-amd64.zip" "https://downloads.rclone.org/${RCLONE_VERSION}/rclone-${RCLONE_VERSION}-linux-amd64.zip"; \
    unzip -q /tmp/rclone-${RCLONE_VERSION}-linux-amd64.zip -d /tmp; \
    cp /tmp/rclone-${RCLONE_VERSION}-linux-amd64/rclone /usr/local/bin/

RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak; \
    sed -i 's http://.*.debian.org http://mirrors.aliyun.com g' /etc/apt/sources.list
