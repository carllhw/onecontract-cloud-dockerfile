FROM debian:buster

ENV TZ="Asia/Shanghai"

# Install base packages
RUN apt-get update; \
    apt-get install -y --no-install-recommends \
        netcat \
        net-tools \
        procps \
        tar \
        telnet \
        unzip \
        vim \
        wget; \
    apt-get upgrade -y --no-install-recommends; \
    rm -rf /var/lib/apt/lists/*

# Add mirror source
RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak; \
    sed -i 's http://.*.debian.org http://mirrors.aliyun.com g' /etc/apt/sources.list
