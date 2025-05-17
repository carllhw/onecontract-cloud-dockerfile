FROM eclipse-temurin:11-jdk-noble

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        dnsutils \
        gettext \
        gnupg2 \
        netcat-openbsd \
        net-tools \
        openssh-client \
        openssl \
        procps \
        tar \
        telnet \
        unzip \
        vim \
        wget; \
    apt-get upgrade -y --no-install-recommends; \
    rm -rf /var/lib/apt/lists/*

ARG user=rocketmq
ARG group=rocketmq
ARG uid=3000
ARG gid=3000

# RocketMQ Dashboard runs with user `rocketmq`, uid = 3000
# If you bind mount a volume from the host or a data container,
# ensure you use the same uid
RUN groupadd -g ${gid} ${group} \
    && useradd -u ${uid} -g ${gid} -m -s /bin/bash ${user}

# install maven
ARG MAVEN_VERSION=3.9.9
ARG MAVEN_DOWNLOAD_URL=https://dlcdn.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz
# rocketmq-dashboard
ENV ROCKETMQ_DASHBOARD_VERSION 2.0.1-SNAPSHOT
ENV ROCKETMQ_DASHBOARD_HOME  /home/rocketmq/rocketmq-dashboard-${ROCKETMQ_DASHBOARD_VERSION}
WORKDIR ${ROCKETMQ_DASHBOARD_HOME}

RUN set -eux; \
    mkdir -p /usr/share/maven /usr/share/maven/ref && \
    wget -O /tmp/apache-maven.tar.gz ${MAVEN_DOWNLOAD_URL} --no-check-certificate && \
    tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 && \
    rm -f /tmp/apache-maven.tar.gz && \
    ln -s /usr/share/maven/bin/mvn /usr/bin/mvn; \
    cat /usr/share/maven/conf/settings.xml; \
    curl -L https://github.com/apache/rocketmq-dashboard/archive/refs/heads/master.zip -o rocketmq-dashboard.zip; \
    unzip rocketmq-dashboard.zip; \
    rm rocketmq-dashboard.zip; \
    cd rocketmq-dashboard-master; \
    mvn -DskipTests clean install ;\
    pwd && ls -l target; \
    cd ${ROCKETMQ_DASHBOARD_HOME}; \
    mkdir bin; \
    mv rocketmq-dashboard-master/target/rocketmq-dashboard-${ROCKETMQ_DASHBOARD_VERSION}.jar bin/; \
    mv bin/rocketmq-dashboard-${ROCKETMQ_DASHBOARD_VERSION}.jar bin/rocketmq-dashboard.jar; \
    ls -l bin; \
    rm -rf rocketmq-dashboard-master; \
    rm -rf /root/.m2/repository/*; \
    rm -rf /usr/share/maven; \
    chown -R ${uid}:${gid} ${ROCKETMQ_DASHBOARD_HOME}

EXPOSE 8080
