FROM eclipse-temurin:11.0.14.1_1-jdk-focal AS jre-build

ARG CI_TRIGGER="20230829-094720"

RUN jlink \
         --add-modules ALL-MODULE-PATH \
         --strip-debug \
         --no-man-pages \
         --no-header-files \
         --compress=2 \
         --output /javaruntime

FROM jenkins/inbound-agent:4.13-1 AS inbound-agent

FROM mcr.microsoft.com/playwright/python:v1.35.0-jammy

# jre
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH "${JAVA_HOME}/bin:${PATH}"
COPY --from=jre-build /javaruntime $JAVA_HOME

# jenkins agent
ARG VERSION=4.13

ARG AGENT_WORKDIR=/root/agent

RUN apt-get update \
  && apt-get -y install \
    git-lfs \
    curl \
    fontconfig \
  && curl --create-dirs -fsSLo /usr/share/jenkins/agent.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${VERSION}/remoting-${VERSION}.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/agent.jar \
  && ln -sf /usr/share/jenkins/agent.jar /usr/share/jenkins/slave.jar \
  && apt-get remove -y curl \
  && rm -rf /var/lib/apt/lists/*

# inbound-agent
COPY --from=inbound-agent /usr/local/bin/jenkins-agent /usr/local/bin/jenkins-agent
RUN chmod +x /usr/local/bin/jenkins-agent &&\
    ln -s /usr/local/bin/jenkins-agent /usr/local/bin/jenkins-slave

ENV LANG C.UTF-8

ENV AGENT_WORKDIR=${AGENT_WORKDIR}
RUN mkdir /root/.jenkins && mkdir -p ${AGENT_WORKDIR}

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
