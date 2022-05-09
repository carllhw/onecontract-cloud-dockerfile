FROM python:3.10

ARG TIMEZONE="Asia/Shanghai"
RUN echo ${TIMEZONE} > /etc/timezone; \
    rm /etc/localtime; \
    dpkg-reconfigure -f noninteractive tzdata

RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak; \
    sed -i 's http://.*.debian.org http://mirrors.aliyun.com g' /etc/apt/sources.list

COPY requirements.txt /opt
RUN pip3 install --no-cache-dir -r /opt/requirements.txt
