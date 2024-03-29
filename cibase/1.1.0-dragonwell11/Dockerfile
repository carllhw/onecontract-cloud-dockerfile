FROM choerodon/cibase:1.1.0-base

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata curl ca-certificates fontconfig locales \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_VERSION jdk-11.0.20.17+8

ARG EDITION=extended

RUN set -eux; \
    ARCH="$(dpkg --print-architecture)"; \
    case "${ARCH}" in \
       aarch64|arm64) \
         if [ "${EDITION}" = "extended" ];then \
           ESUM='2dc7bd1ad96cc9aa2aefb27003851d07b6a9c2940bfab9982fac86b8e5b52b0d'; \
           BINARY_URL='https://github.com/dragonwell-project/dragonwell11/releases/download/dragonwell-extended-11.0.20.17_jdk-11.0.20-ga/Alibaba_Dragonwell_Extended_11.0.20.17.8_aarch64_linux.tar.gz'; \
         else \
           ESUM='5c0b7ad09352d3cb2b55fd641c94daefb1d51b87aaee12a3ed2aad88d533effa'; \
           BINARY_URL='https://github.com/dragonwell-project/dragonwell11/releases/download/dragonwell-standard-11.0.20.16_jdk-11.0.20-ga/Alibaba_Dragonwell_Standard_11.0.20.16.8_aarch64_linux.tar.gz'; \
         fi \
         ;; \
       amd64|i386:x86-64) \
         if [ "${EDITION}" = "extended" ];then \
           ESUM='83f7fb3afe467b2f91c5404dc9d6dee0346d90ae827a3954a897b7e55f3b290b'; \
           BINARY_URL='https://github.com/dragonwell-project/dragonwell11/releases/download/dragonwell-extended-11.0.20.17_jdk-11.0.20-ga/Alibaba_Dragonwell_Extended_11.0.20.17.8_x64_linux.tar.gz'; \
         else \
           ESUM='5011ac706a856b58642ba51615eaa5d874f94cd8abe6e56fbc32666130893419'; \
           BINARY_URL='https://github.com/dragonwell-project/dragonwell11/releases/download/dragonwell-standard-11.0.20.16_jdk-11.0.20-ga/Alibaba_Dragonwell_Standard_11.0.20.16.8_x64_linux.tar.gz'; \
         fi \
         ;; \
       *) \
         echo "Unsupported arch: ${ARCH}"; \
         exit 1; \
         ;; \
    esac; \
    curl -LfsSo /tmp/openjdk.tar.gz ${BINARY_URL}; \
    echo "${ESUM} */tmp/openjdk.tar.gz" | sha256sum -c -; \
    mkdir -p /opt/java/openjdk; \
    cd /opt/java/openjdk; \
    tar -xf /tmp/openjdk.tar.gz --strip-components=1; \
    rm -rf /tmp/openjdk.tar.gz;

ENV JAVA_HOME=/opt/java/openjdk \
    PATH="/opt/java/openjdk/bin:$PATH"

RUN echo Verifying install ... \
    && echo javac --version && javac --version \
    && echo java --version && java --version \
    && echo Complete.

# Ref: https://github.com/carlossg/docker-maven/blob/59bdaf8b1ec69a787d7857cd1025f1f3efd7b216/openjdk-8/Dockerfile
# Install Maven Start
ARG MAVEN_VERSION=3.8.8
ARG USER_HOME_DIR="/root"
ARG SHA=f790857f3b1f90ae8d16281f902c689e4f136ebe584aba45e4b1fa66c80cba826d3e0e52fdd04ed44b4c66f6d3fe3584a057c26dfcac544a60b301e6d0f91c26
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  # && echo "${SHA}  /tmp/apache-maven.tar.gz" | sha512sum -c - \
  && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
  && rm -f /tmp/apache-maven.tar.gz \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn \
  # disable 'maven-default-http-blocker'
  && sed -i '159,165d' /usr/share/maven/conf/settings.xml \
  && cat /usr/share/maven/conf/settings.xml

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"
# Install Maven End

ARG JIB_VERSION=0.12.0
ARG DOCKER_BUILDX_VERSION=v0.10.2
ENV PATH="/opt/jib/bin:${PATH}"

RUN set -eux; \
    ARCH="$(dpkg --print-architecture)"; \
# install jib
    wget -qO /tmp/jib-jre-${JIB_VERSION}.zip \
        https://github.com/GoogleContainerTools/jib/releases/download/v${JIB_VERSION}-cli/jib-jre-${JIB_VERSION}.zip; \
    unzip /tmp/jib-jre-${JIB_VERSION}.zip -d /tmp/; \
    mv /tmp/jib-${JIB_VERSION} /opt/jib; \
    rm /tmp/jib-jre-${JIB_VERSION}.zip; \
# install docker buildx
    mkdir -p /usr/local/lib/docker/cli-plugins; \
    wget -qO /usr/local/lib/docker/cli-plugins/docker-buildx \
        https://github.com/docker/buildx/releases/download/${DOCKER_BUILDX_VERSION}/buildx-${DOCKER_BUILDX_VERSION}.linux-${ARCH}; \
    chmod +x /usr/local/lib/docker/cli-plugins/docker-buildx
