FROM choerodon/cibase:0.11.4

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
