FROM jenkins/inbound-agent:4.13-1

ARG CI_TRIGGER="20220524-180842"
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
        python3-pip \
        python3-dev \
        ttf-wqy-microhei \
        ttf-wqy-zenhei \
        unzip \
        xfonts-wqy \
        zip \
        zlib1g-dev; \
    apt-get upgrade -y --no-install-recommends; \
    rm -rf /var/lib/apt/lists/*;

COPY requirements.txt /opt
RUN pip3 install --no-cache-dir -r /opt/requirements.txt

USER ${user}
