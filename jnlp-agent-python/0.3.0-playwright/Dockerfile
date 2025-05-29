FROM eclipse-temurin:21-jdk-jammy AS jre-build

ARG CI_TRIGGER="20250529-111421"

RUN jlink \
         --add-modules ALL-MODULE-PATH \
         --strip-debug \
         --no-man-pages \
         --no-header-files \
         --compress=2 \
         --output /javaruntime

# https://github.com/jenkinsci/docker-agent/blob/master/debian/Dockerfile
FROM jenkins/inbound-agent:3309.v27b_9314fd1a_4-3 AS inbound-agent

FROM mcr.microsoft.com/playwright/python:v1.52.0-jammy

# jre
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH "${JAVA_HOME}/bin:${PATH}"
COPY --from=jre-build /javaruntime $JAVA_HOME

# jenkins agent
ARG VERSION=3309.v27b_9314fd1a_4

ARG AGENT_WORKDIR=/root/agent

RUN apt-get update \
  && apt-get -y install \
    git-lfs \
    curl \
    fontconfig \
    unzip \
    wget \
  && curl --create-dirs -fsSLo /usr/share/jenkins/agent.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${VERSION}/remoting-${VERSION}.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/agent.jar \
  && ln -sf /usr/share/jenkins/agent.jar /usr/share/jenkins/slave.jar \
  && rm -rf /var/lib/apt/lists/*

# inbound-agent
COPY --from=inbound-agent /usr/local/bin/jenkins-agent /usr/local/bin/jenkins-agent
RUN chmod +x /usr/local/bin/jenkins-agent &&\
    ln -s /usr/local/bin/jenkins-agent /usr/local/bin/jenkins-slave

ENV LANG C.UTF-8

ENV AGENT_WORKDIR=${AGENT_WORKDIR}
RUN mkdir /root/.jenkins && mkdir -p ${AGENT_WORKDIR}

# allure2
ARG ALLURE2_VERSION=2.34.0
RUN wget -qO /tmp/allure.zip "https://github.com/allure-framework/allure2/releases/download/${ALLURE2_VERSION}/allure-${ALLURE2_VERSION}.zip"; \
    unzip /tmp/allure.zip -d /opt/; \
    mv /opt/allure-${ALLURE2_VERSION} /opt/allure; \
    ln -s /opt/allure/bin/allure /usr/local/bin/allure; \
    rm -f /tmp/allure.zip

# python
ARG DEBIAN_FRONTEND=noninteractive
ARG TIMEZONE="Asia/Shanghai"
RUN apt-get update; \
    apt-get install -y \
        tzdata; \
    apt-get upgrade -y --no-install-recommends; \
    echo ${TIMEZONE} > /etc/timezone; \
    rm /etc/localtime; \
    dpkg-reconfigure -f noninteractive tzdata; \
    rm -rf /var/lib/apt/lists/*;
COPY requirements.txt /root
RUN pip3 install --no-cache-dir -r /root/requirements.txt; \
    playwright install-deps; \
    playwright install
COPY locust_plugins/users/playwright.py /usr/local/lib/python3.10/dist-packages/locust_plugins/users/playwright.py
