FROM choerodon/cibase:1.1.0-base

RUN set -eux; \
    ARCH="$(dpkg --print-architecture)"; \
    rm /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata curl ca-certificates fontconfig locales \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_VERSION jdk-11.0.18.14+9

ARG EDITION=extended

RUN set -eux; \
    ARCH="$(dpkg --print-architecture)"; \
    case "${ARCH}" in \
       aarch64|arm64) \
         if [ "${EDITION}" = "extended" ];then \
           ESUM='04d257942c75eb487075b675da0dcec6319dbf9dcdc5ed93eafbd427398f4e08'; \
           BINARY_URL='https://github.com/alibaba/dragonwell11/releases/download/dragonwell-extended-11.0.18.14_jdk-11.0.18-ga/Alibaba_Dragonwell_Extended_11.0.18.14.9_aarch64_linux.tar.gz'; \
         else \
           ESUM='cc05189481c899c434e25320bf3de9c03b72ac7e1bc2950fe749ed9063340f65'; \
           BINARY_URL='https://github.com/alibaba/dragonwell11/releases/download/dragonwell-standard-11.0.18.14_jdk-11.0.18-ga/Alibaba_Dragonwell_Standard_11.0.18.14.9_aarch64_linux.tar.gz'; \
         fi \
         ;; \
       amd64|i386:x86-64) \
         if [ "${EDITION}" = "extended" ];then \
           ESUM='4d02a4cce2d13ead8d54650c5e9bf560a6a1f79b6e7281fbb46e31ea3c20a341'; \
           BINARY_URL='https://github.com/alibaba/dragonwell11/releases/download/dragonwell-extended-11.0.18.14_jdk-11.0.18-ga/Alibaba_Dragonwell_Extended_11.0.18.14.9_x64_linux.tar.gz'; \
         else \
           ESUM='2360b063f1099c0ab7def15ec83c7344ae21038e5a85139132dc4005a8d5a940'; \
           BINARY_URL='https://github.com/alibaba/dragonwell11/releases/download/dragonwell-standard-11.0.18.14_jdk-11.0.18-ga/Alibaba_Dragonwell_Standard_11.0.18.14.9_x64_linux.tar.gz'; \
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
