FROM choerodon/cibase:1.1.0-base

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata curl ca-certificates fontconfig locales \
    && apt-get upgrade -y --no-install-recommends \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_VERSION jdk8u382-b01

ARG EDITION=extended

RUN set -eux; \
    ARCH="$(dpkg --print-architecture)"; \
    case "${ARCH}" in \
       aarch64|arm64) \
         if [ "${EDITION}" = "extended" ];then \
           ESUM='2602b8f707b1a15a628bfdc9396bfdf9906d420172871e64a02a1604871cdc91'; \
           BINARY_URL='https://github.com/dragonwell-project/dragonwell8/releases/download/dragonwell-extended-8.16.17_jdk8u382-ga/Alibaba_Dragonwell_Extended_8.16.17_aarch64_linux.tar.gz'; \
         else \
           ESUM='18f4b12c983a38425de86d6f13b46de0526ee9a19dbdeba3431fad35cb6e7b15'; \
           BINARY_URL='https://github.com/dragonwell-project/dragonwell8/releases/download/dragonwell-standard-8.16.17_jdk8u382-ga/Alibaba_Dragonwell_Standard_8.16.17_aarch64_linux.tar.gz'; \
         fi \
         ;; \
       amd64|i386:x86-64) \
         if [ "${EDITION}" = "extended" ];then \
           ESUM='fe79b0c2081f894f82396179abb4dac93c6e887df07d1321ca3e5dca596ebea7'; \
           BINARY_URL='https://github.com/dragonwell-project/dragonwell8/releases/download/dragonwell-extended-8.16.17_jdk8u382-ga/Alibaba_Dragonwell_Extended_8.16.17_x64_linux.tar.gz'; \
         else \
           ESUM='18d483c5cc1c16591fce9a84c605275570c5ea325c15a2ecb4e05e7a81956e72'; \
           BINARY_URL='https://github.com/dragonwell-project/dragonwell8/releases/download/dragonwell-standard-8.16.17_jdk8u382-ga/Alibaba_Dragonwell_Standard_8.16.17_x64_linux.tar.gz'; \
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
    && echo javac -version && javac -version \
    && echo java -version && java -version \
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
