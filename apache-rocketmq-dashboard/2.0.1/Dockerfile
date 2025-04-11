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
ARG MAVEN_VERSION=3.8.8
ARG MAVEN_DOWNLOAD_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz

RUN mkdir -p /usr/share/maven /usr/share/maven/ref && \
    wget -O /tmp/apache-maven.tar.gz ${MAVEN_DOWNLOAD_URL} --no-check-certificate && \
    tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 && \
    rm -f /tmp/apache-maven.tar.gz && \
    ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

RUN cat /usr/share/maven/conf/settings.xml

ENV ROCKETMQ_DASHBOARD_VERSION 2.0.1-SNAPSHOT
ENV ROCKETMQ_DASHBOARD_HOME  /home/rocketmq/rocketmq-dashboard-${ROCKETMQ_DASHBOARD_VERSION}
WORKDIR ${ROCKETMQ_DASHBOARD_HOME}

RUN set -eux; \
    curl -L https://github.com/apache/rocketmq-dashboard/archive/refs/heads/master.zip -o rocketmq-dashboard.zip; \
    unzip rocketmq-dashboard.zip ; \
    rm rocketmq-dashboard.zip

RUN cd rocketmq-dashboard-master ; \
    mvn -DskipTests clean install ;\
    ls -l target

RUN mkdir bin; \
    mv rocketmq-dashboard-master/target/rocketmq-dashboard-${ROCKETMQ_DASHBOARD_VERSION}.jar bin/ ; \
    mv bin/rocketmq-dashboard-${ROCKETMQ_DASHBOARD_VERSION}.jar bin/rocketmq-dashboard.jar; \
    ls -l bin; \
    rm -rf rocketmq-dashboard-master

RUN rm -rf /root/.m2/repository/*
RUN rm -rf /usr/share/maven

RUN chown -R ${uid}:${gid} ${ROCKETMQ_DASHBOARD_HOME}
EXPOSE 8080
