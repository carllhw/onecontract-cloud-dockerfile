FROM debian:buster

RUN apt-get update; \
    apt-get install -y --no-install-recommends \
        dnsutils \
        easy-rsa \
        iptables \
        mawk \
        netmask \
        openssl \
        openvpn \
        python-kerberos \
        python-ldap \
        python-paramiko \
        python-requests \
        rsync \
        wget \
    apt-get upgrade -y --no-install-recommends; \
    rm -rf /var/lib/apt/lists/*;

COPY bin/* /usr/local/bin/
RUN chmod 744 /usr/local/bin/openvpn-* && \
    chown root:root /usr/local/bin/openvpn-*

CMD ["/usr/local/bin/openvpn-enterpoint.sh"]
