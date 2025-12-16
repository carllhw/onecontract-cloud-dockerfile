FROM python:3.12

ARG CI_TRIGGER="20251107-155533"

ENV TZ="Asia/Shanghai"

RUN set -eux; \
    ARCH="$(dpkg --print-architecture)"; \
    apt update; \
    apt install -y --no-install-recommends \
        mariadb-client \
        pipx; \
    pipx ensurepath; \
    pipx install poetry; \
    echo ${TZ} > /etc/timezone; \
    rm /etc/localtime; \
    dpkg-reconfigure -f noninteractive tzdata; \
    rm -rf /var/lib/apt/lists/*

RUN cp /etc/apt/sources.list.d/debian.sources /etc/apt/sources.list.d/debian.sources.bak; \
    sed -i 's/deb.debian.org/repo.huaweicloud.com/g' /etc/apt/sources.list.d/debian.sources

COPY requirements.txt /opt
RUN pip3 install --no-cache-dir -r /opt/requirements.txt
COPY pip.conf /root/.pip/pip.conf
