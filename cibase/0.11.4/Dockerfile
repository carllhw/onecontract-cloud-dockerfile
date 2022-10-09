FROM choerodon/cibase:0.11.4

ARG JIB_VERSION=0.11.0
ENV PATH="/opt/jib/bin:${PATH}"

RUN set -eux; \
    ARCH="$(dpkg --print-architecture)"; \
# install jib
    wget -qO /tmp/jib-jre-${JIB_VERSION}.zip \
        https://github.com/GoogleContainerTools/jib/releases/download/v${JIB_VERSION}-cli/jib-jre-${JIB_VERSION}.zip; \
    unzip /tmp/jib-jre-${JIB_VERSION}.zip -d /tmp/; \
    mv /tmp/jib-${JIB_VERSION} /opt/jib; \
    rm /tmp/jib-jre-${JIB_VERSION}.zip
