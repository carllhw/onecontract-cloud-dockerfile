FROM ubuntu:20.04

ENV TZ="Asia/Shanghai"

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

RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak; \
    sed -i 's http://.*.ubuntu.com http://mirrors.aliyun.com g' /etc/apt/sources.list
