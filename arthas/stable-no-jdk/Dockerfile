FROM alpine

ARG ARTHAS_VERSION="4.0.5"
ARG MIRROR=false

ENV MAVEN_HOST=https://repo1.maven.org/maven2 \
  MIRROR_MAVEN_HOST=https://maven.aliyun.com/repository/public

# if use mirror change to aliyun mirror site
RUN if $MIRROR; then MAVEN_HOST=${MIRROR_MAVEN_HOST} ; fi && \
  # download & install arthas
  wget -qO /tmp/arthas.zip "${MAVEN_HOST}/com/taobao/arthas/arthas-packaging/${ARTHAS_VERSION}/arthas-packaging-${ARTHAS_VERSION}-bin.zip" && \
  mkdir -p /opt/arthas && \
  unzip /tmp/arthas.zip -d /opt/arthas && \
  rm /tmp/arthas.zip
