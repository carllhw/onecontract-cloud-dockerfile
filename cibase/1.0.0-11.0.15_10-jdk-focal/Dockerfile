FROM eclipse-temurin:11.0.15_10-jdk-focal AS jre-build

RUN jlink \
         --add-modules ALL-MODULE-PATH \
         --strip-debug \
         --no-man-pages \
         --no-header-files \
         --compress=2 \
         --output /javaruntime

FROM choerodon/cibase:1.0.0-base

# jre
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH "${JAVA_HOME}/bin:${PATH}"
COPY --from=jre-build /javaruntime $JAVA_HOME

# Ref: https://github.com/carlossg/docker-maven/blob/59bdaf8b1ec69a787d7857cd1025f1f3efd7b216/openjdk-8/Dockerfile
# Install Maven Start
ARG MAVEN_VERSION=3.8.7
ARG USER_HOME_DIR="/root"
ARG SHA=a9b2d825eacf2e771ed5d6b0e01398589ac1bfa4171f36154d1b5787879605507802f699da6f7cfc80732a5282fd31b28e4cd6052338cbef0fa1358b48a5e3c8
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
