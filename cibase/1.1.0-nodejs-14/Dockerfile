FROM choerodon/cibase:1.1.0-base

ARG DOCKER_BUILDX_VERSION=v0.10.2
ENV PATH="/opt/jib/bin:${PATH}"

RUN set -eux; \
    ARCH="$(dpkg --print-architecture)"; \
    rm /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list; \
# install docker buildx
    mkdir -p /usr/local/lib/docker/cli-plugins; \
    wget -qO /usr/local/lib/docker/cli-plugins/docker-buildx \
        https://github.com/docker/buildx/releases/download/${DOCKER_BUILDX_VERSION}/buildx-${DOCKER_BUILDX_VERSION}.linux-${ARCH}; \
    chmod +x /usr/local/lib/docker/cli-plugins/docker-buildx; \
# install node
    curl -sSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -; \
    echo 'deb https://deb.nodesource.com/node_14.x buster main' > /etc/apt/sources.list.d/nodesource.list; \
    apt-get update; \
    apt-get upgrade -y; \
    apt-get install -y \
        nodejs; \
	rm -rf /var/lib/apt/lists/*; \
# install yarn
    npm install -g yarn; \
# install typescript
    npm install -g typescript@${TYPESCRIPT_VERSION}; \
    npm install -g npm-cli-login
