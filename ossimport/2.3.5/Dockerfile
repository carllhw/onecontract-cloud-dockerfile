FROM ghcr.io/carllhw/onecontract-cloud_adoptopenjdk:jdk8u292-b10

ARG OSSIMPORT_VERSION=2.3.5

ENV TZ="Asia/Shanghai"

# Install base packages
RUN apt-get update; \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        dnsutils \
        gnupg2 \
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
    rm -rf /var/lib/apt/lists/*

# Install ossimport
RUN curl -LfsSo "/tmp/ossimport.tar.gz" \
        "https://gosspublic.alicdn.com/ossimport/distributed/ossimport-${OSSIMPORT_VERSION}.tar.gz"; \
    tar -C /opt/ -xf /tmp/ossimport.tar.gz; \
    rm -r /tmp/*;

# Add mirror source
RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak; \
    sed -i 's http://.*.debian.org http://mirrors.aliyun.com g' /etc/apt/sources.list
