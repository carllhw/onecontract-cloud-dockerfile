FROM jenkins/inbound-agent:3273.v4cfe589b_fd83-2

ARG CI_TRIGGER="20241031-101429"
ARG user=jenkins

USER root

ARG TIMEZONE="Asia/Shanghai"
RUN echo ${TIMEZONE} > /etc/timezone; \
    rm /etc/localtime; \
    dpkg-reconfigure -f noninteractive tzdata

RUN apt-get update; \
    apt-get install -y \
        build-essential \
        curl \
        git \
        libffi-dev \
        libgdbm-dev \
        libncurses5-dev \
        libnss3-dev \
        libreadline-dev \
        libssl-dev \
        python3-dev \
        python3-pip \
        ttf-wqy-microhei \
        ttf-wqy-zenhei \
        unzip \
        xfonts-wqy \
        zip \
        zlib1g-dev; \
    apt-get upgrade -y --no-install-recommends; \
    rm -rf /var/lib/apt/lists/*;

COPY requirements.txt /opt
RUN pip3 install --no-cache-dir --break-system-packages -r /opt/requirements.txt

USER ${user}
