FROM choerodon/cibase:1.1.0-base

RUN set -eux; \
    ARCH="$(dpkg --print-architecture)"; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        protobuf-compiler; \
    apt-get upgrade -y --no-install-recommends; \
    rm -rf /var/lib/apt/lists/*