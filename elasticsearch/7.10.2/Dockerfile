FROM docker.elastic.co/elasticsearch/elasticsearch:7.10.2

ARG ELASTICSEARCH_VERSION=7.10.2
ARG LOG4J_VERSION=2.17.1

RUN set -eux; \
    # analysis-ik
    curl -LfsSo "/tmp/elasticsearch-analysis-ik-${ELASTICSEARCH_VERSION}.zip" \
        "https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v${ELASTICSEARCH_VERSION}/elasticsearch-analysis-ik-${ELASTICSEARCH_VERSION}.zip"; \
    bin/elasticsearch-plugin install --batch file:///tmp/elasticsearch-analysis-ik-${ELASTICSEARCH_VERSION}.zip; \
    rm -r /tmp/*;

# security
RUN set -eux; \
    # https://logging.apache.org/log4j/2.x/security.html
    rm -f /usr/share/elasticsearch/lib/log4j*; \
    curl -LfsSo "/usr/share/elasticsearch/lib/log4j-api-${LOG4J_VERSION}.jar" "https://maven.aliyun.com/repository/public/org/apache/logging/log4j/log4j-api/${LOG4J_VERSION}/log4j-api-${LOG4J_VERSION}.jar"; \
    curl -LfsSo "/usr/share/elasticsearch/lib/log4j-core-${LOG4J_VERSION}.jar" "https://maven.aliyun.com/repository/public/org/apache/logging/log4j/log4j-core/${LOG4J_VERSION}/log4j-core-${LOG4J_VERSION}.jar"; \
    rm -f /usr/share/elasticsearch/modules/x-pack-core/log4j*; \
    curl -LfsSo "/usr/share/elasticsearch/modules/x-pack-core/log4j-1.2-api-${LOG4J_VERSION}.jar" "https://maven.aliyun.com/repository/public/org/apache/logging/log4j/log4j-1.2-api/${LOG4J_VERSION}/log4j-1.2-api-${LOG4J_VERSION}.jar"
