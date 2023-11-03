FROM onecontract/openeuler:22.03-lts-sp2

ARG TARGETPLATFORM

ENV LANG=en_US.utf8 \
    GAUSSLOG=/home/omm/pg_log \
    PGDATA=/var/lib/opengauss/data \
    GOSU_VERSION=1.17

RUN set -eux; \
    yum install -y \
        bison \
        bzip2-devel \
        curl \
        dnsutils \
        findutils \
        flex \
        glibc-devel \
        iproute \
        iputils \
        libaio-devel \
        libnsl \
        lsof \
        ncurses-devel \
        net-tools \
        nmap \
        numactl-devel \
        openeuler-lsb \
        patch \
        readline-devel \
        util-linux \
        vim \
        wget; \
    case "${TARGETPLATFORM}" in \
        "linux/amd64") \
          wget -qO /tmp/openGauss.tar.bz2 \
        https://opengauss.obs.cn-south-1.myhuaweicloud.com/5.0.0/x86_openEuler_2203/openGauss-5.0.0-openEuler-64bit.tar.bz2; \
          wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-amd64"; \
          ;; \
        "linux/arm64") \
          wget -qO /tmp/openGauss.tar.bz2 \
        https://opengauss.obs.cn-south-1.myhuaweicloud.com/5.0.0/arm_2203/openGauss-5.0.0-openEuler-64bit.tar.bz2; \
          wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-arm64"; \
          ;; \
        *) \
          echo "Unsupported platform: ${TARGETPLATFORM}"; \
          exit 1; \
          ;; \
    esac ; \
    groupadd -g 70 omm;  \
    useradd -u 70 -g omm -m -s /bin/bash omm; \
    mkdir -p /var/lib/opengauss; \
    mkdir -p /usr/local/opengauss; \
    mkdir -p /var/run/opengauss; \
    mkdir /docker-entrypoint-initdb.d; \
    tar -xjf /tmp/openGauss.tar.bz2 -C /usr/local/opengauss; \
    chown -R omm:omm /usr/local/opengauss; \
    chown omm:omm /var/lib/opengauss /home/omm /var/run/opengauss /docker-entrypoint-initdb.d; \
    echo "export GAUSSLOG=/home/omm/pg_log" >> /home/omm/.bashrc; \
    echo "export GAUSSHOME=/usr/local/opengauss" >> /home/omm/.bashrc; \
    echo "export PGDATA=/var/lib/opengauss/data" >> /home/omm/.bashrc; \
    echo "export PATH=\$GAUSSHOME/bin:\$PATH " >> /home/omm/.bashrc; \
    echo "export LD_LIBRARY_PATH=\$GAUSSHOME/lib:\$LD_LIBRARY_PATH" >> /home/omm/.bashrc; \
    chmod +x /usr/local/bin/gosu; \
    rm /tmp/openGauss.tar.bz2; \
    yum clean all

COPY entrypoint.sh /usr/local/bin/
RUN set -eux; \
    chmod 755 /usr/local/bin/entrypoint.sh && ln -s /usr/local/bin/entrypoint.sh /; \
    sed -i "s#http://repo.openeuler.org#https://mirrors.huaweicloud.com/openeuler#g" /etc/yum.repos.d/openEuler.repo

ENTRYPOINT ["entrypoint.sh"]
EXPOSE 5432
CMD ["gaussdb"]
