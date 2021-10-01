FROM debian:buster

ENV TZ="Asia/Shanghai"

RUN apt-get update; \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        dnsutils \
        easy-rsa \
        gnupg \
        iptables \
        mawk \
        netmask \
        net-tools \
        openssl \
        openvpn \
        python-kerberos \
        python-ldap \
        python-paramiko \
        python-requests \
        rsync \
        wget; \
    apt-get upgrade -y --no-install-recommends; \
    rm -rf /var/lib/apt/lists/*; \
    cp /etc/apt/sources.list /etc/apt/sources.list.bak; \
    sed -i 's http://.*.debian.org http://mirrors.aliyun.com g' /etc/apt/sources.list

COPY bin/* /usr/local/bin/

RUN chmod 744 /usr/local/bin/openvpn-* && \
    chown root:root /usr/local/bin/openvpn-*

CMD ["/usr/local/bin/openvpn-enterpoint.sh"]
