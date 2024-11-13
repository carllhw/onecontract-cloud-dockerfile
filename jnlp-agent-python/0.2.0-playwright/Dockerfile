FROM eclipse-temurin:17-jdk-focal AS jre-build

ARG CI_TRIGGER="20241031-101429"

RUN jlink \
         --add-modules ALL-MODULE-PATH \
         --strip-debug \
         --no-man-pages \
         --no-header-files \
         --compress=2 \
         --output /javaruntime

# https://github.com/jenkinsci/docker-agent/blob/master/debian/Dockerfile
FROM jenkins/inbound-agent:3273.v4cfe589b_fd83-2 AS inbound-agent

FROM mcr.microsoft.com/playwright/python:v1.35.0-jammy

# jre
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH "${JAVA_HOME}/bin:${PATH}"
COPY --from=jre-build /javaruntime $JAVA_HOME

# jenkins agent
ARG VERSION=3273.v4cfe589b_fd83

ARG AGENT_WORKDIR=/root/agent

RUN apt-get update \
  && apt-get -y install \
    git-lfs \
    curl \
    fontconfig \
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
RUN wget -qO /tmp/allure_all.deb "https://github.com/allure-framework/allure2/releases/download/2.32.0/allure_2.32.0-1_all.deb"; \
    dpkg -i /tmp/allure_all.deb; \
    rm -f /tmp/allure_all.deb

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
    playwright install
COPY locust_plugins/users/playwright.py /usr/local/lib/python3.10/dist-packages/locust_plugins/users/playwright.py
