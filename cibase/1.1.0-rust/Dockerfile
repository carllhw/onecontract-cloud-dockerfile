FROM choerodon/cibase:1.1.0-base

ARG DOCKER_BUILDX_VERSION=v0.11.2

RUN set -eux; \
    ARCH="$(dpkg --print-architecture)"; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        libssl-dev \
        musl-tools \
        pkg-config \
        protobuf-compiler; \
    case "${ARCH}" in \
        amd64|x86_64) \
          apt-get install -y \
            clang \
            cmake \
            gcc-aarch64-linux-gnu \
            llvm ;\
        ;; \
        *) \
         echo "arch: ${ARCH}"; \
         ;; \
    esac; \
    apt-get upgrade -y --no-install-recommends; \
    rm -rf /var/lib/apt/lists/*; \
# install docker buildx
    mkdir -p /usr/local/lib/docker/cli-plugins; \
    wget -qO /usr/local/lib/docker/cli-plugins/docker-buildx \
        https://github.com/docker/buildx/releases/download/${DOCKER_BUILDX_VERSION}/buildx-${DOCKER_BUILDX_VERSION}.linux-${ARCH}; \
    chmod +x /usr/local/lib/docker/cli-plugins/docker-buildx
