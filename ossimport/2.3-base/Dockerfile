FROM ghcr.io/carllhw/onecontract-cloud_adoptopenjdk:jdk8u292-b10

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
        openssh-server \
        procps \
        tar \
        telnet \
        unzip \
        vim \
        wget; \
    apt-get upgrade -y --no-install-recommends; \
    # ssh
    mkdir -p /run/sshd; \
    # OssImport
    mkdir /root/ossimport; \
    rm -rf /var/lib/apt/lists/*

# Add mirror source
RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak; \
    sed -i 's http://.*.debian.org http://mirrors.aliyun.com g' /etc/apt/sources.list

WORKDIR /root/ossimport

EXPOSE 22

CMD [ "/bin/sh","-c","/usr/sbin/sshd -D" ]
