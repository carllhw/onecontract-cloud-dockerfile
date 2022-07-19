FROM eclipse-temurin:11.0.14.1_1-jdk-focal AS jre-build

ARG CI_TRIGGER="20220719-183556"

RUN jlink \
         --add-modules ALL-MODULE-PATH \
         --strip-debug \
         --no-man-pages \
         --no-header-files \
         --compress=2 \
         --output /javaruntime

FROM jenkins/inbound-agent:4.13-1 AS inbound-agent

FROM marketsquare/robotframework-browser:12.3.0

USER root

# jre
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH "${JAVA_HOME}/bin:${PATH}"
COPY --from=jre-build /javaruntime $JAVA_HOME

# jenkins agent
ARG VERSION=4.13
ARG user=pwuser

ARG AGENT_WORKDIR=/home/${user}/agent

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
RUN mkdir /home/${user}/.jenkins && mkdir -p ${AGENT_WORKDIR}

# auto
ARG TIMEZONE="Asia/Shanghai"
RUN set -eux; \
    echo ${TIMEZONE} > /etc/timezone; \
    rm /etc/localtime; \
    dpkg-reconfigure -f noninteractive tzdata; \
    npx playwright install-deps
USER ${user}
COPY requirements.txt /home/${user}
RUN set -eux; \
    pip install --no-cache-dir -r /home/${user}/requirements.txt; \
    cp -r -a /home/pwuser/.local/lib/python3.8/site-packages/Browser/wrapper/node_modules /usr/lib/node_modules/playwright/node_modules

VOLUME /home/${user}/.jenkins
VOLUME ${AGENT_WORKDIR}
WORKDIR /home/${user}
