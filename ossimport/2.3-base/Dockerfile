FROM ghcr.io/carllhw/onecontract-cloud_adoptopenjdk:jdk8u292-b10

ENV TZ="Asia/Shanghai"
ENV LANG='zh_CN.UTF-8' LANGUAGE='zh_CN.UTF-8' LC_ALL='zh_CN.UTF-8'

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
    # locale
    && echo "zh_CN.UTF-8 UTF-8" >> /etc/locale.gen; \
    && locale-gen zh_CN.UTF-8; \
    # ssh
    mkdir -p /run/sshd; \
    # ossimport
    mkdir /root/import; \
    rm -rf /var/lib/apt/lists/*

# Add mirror source
RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak; \
    sed -i 's http://.*.debian.org http://mirrors.aliyun.com g' /etc/apt/sources.list

WORKDIR /root/import

EXPOSE 22

CMD [ "/bin/sh","-c","/usr/sbin/sshd -D" ]
