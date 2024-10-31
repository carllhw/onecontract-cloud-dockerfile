FROM eclipse-temurin:17-jdk-focal AS jre-build

ARG CI_TRIGGER="20230131-104807"

RUN jlink \
         --add-modules ALL-MODULE-PATH \
         --strip-debug \
         --no-man-pages \
         --no-header-files \
         --compress=2 \
         --output /javaruntime

FROM jenkins/inbound-agent:3273.v4cfe589b_fd83-2 AS inbound-agent

FROM marketsquare/robotframework-browser:16.0.2

USER root

# jre
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH "${JAVA_HOME}/bin:${PATH}"
COPY --from=jre-build /javaruntime $JAVA_HOME

# jenkins agent
ARG VERSION=3273.v4cfe589b_fd83
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

USER ${user}
ENV AGENT_WORKDIR=${AGENT_WORKDIR}
RUN mkdir /home/${user}/.jenkins && mkdir -p ${AGENT_WORKDIR}
USER root

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
    pip3 install --no-cache-dir -r /home/${user}/requirements.txt

VOLUME /home/${user}/.jenkins
VOLUME ${AGENT_WORKDIR}
WORKDIR /home/${user}
