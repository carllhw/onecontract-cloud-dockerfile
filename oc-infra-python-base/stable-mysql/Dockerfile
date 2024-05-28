FROM mysql:8.0-debian as mysql
FROM python:3.11

ARG CI_TRIGGER="20230902-074233"

ENV TZ="Asia/Shanghai"

COPY --from=mysql /usr/bin/mysql /usr/bin/mysql
COPY --from=mysql /usr/bin/mysqlpump /usr/bin/mysqlpump
COPY --from=mysql /usr/bin/lz4_decompress /usr/bin/lz4_decompress

RUN set -eux; \
    ARCH="$(dpkg --print-architecture)"; \
    echo ${TZ} > /etc/timezone; \
    rm /etc/localtime; \
    dpkg-reconfigure -f noninteractive tzdata

RUN cp /etc/apt/sources.list.d/debian.sources /etc/apt/sources.list.d/debian.sources.bak; \
    sed -i 's http://.*.debian.org http://mirrors.aliyun.com g' /etc/apt/sources.list.d/debian.sources

COPY requirements.txt /opt
RUN pip3 install --no-cache-dir -r /opt/requirements.txt
