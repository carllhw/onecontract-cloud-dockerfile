FROM nginx:1.20

# Modify timezone
ENV TZ=Asia/Shanghai

# Install base packages
RUN apt-get update; \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        dnsutils \
        netcat \
        net-tools \
        procps \
        vim; \
    apt-get upgrade -y --no-install-recommends; \
    rm -rf /var/lib/apt/lists/*;

# Nginx conf
ADD default.conf /etc/nginx/conf.d/default.conf

# aliyun mirror
RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak; \
    sed -i 's http://.*.debian.org http://mirrors.aliyun.com g' /etc/apt/sources.list
