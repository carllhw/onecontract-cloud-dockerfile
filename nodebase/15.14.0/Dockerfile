FROM node:15.14.0

ENV TZ="Asia/Shanghai"

RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak; \
    sed -i "s@http://ftp.debian.org@https://repo.huaweicloud.com@g" /etc/apt/sources.list; \
    sed -i "s@http://security.debian.org@https://repo.huaweicloud.com@g" /etc/apt/sources.list
