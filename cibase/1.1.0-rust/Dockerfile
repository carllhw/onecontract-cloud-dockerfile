FROM choerodon/cibase:1.1.0-base

ARG DOCKER_BUILDX_VERSION=v0.10.2

RUN set -eux; \
    ARCH="$(dpkg --print-architecture)"; \
    rm /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        protobuf-compiler; \
    apt-get upgrade -y --no-install-recommends; \
    rm -rf /var/lib/apt/lists/*; \
# install docker buildx
    mkdir -p /usr/local/lib/docker/cli-plugins; \
    wget -qO /usr/local/lib/docker/cli-plugins/docker-buildx \
        https://github.com/docker/buildx/releases/download/${DOCKER_BUILDX_VERSION}/buildx-${DOCKER_BUILDX_VERSION}.linux-${ARCH}; \
    chmod +x /usr/local/lib/docker/cli-plugins/docker-buildx
