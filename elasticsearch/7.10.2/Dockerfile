FROM docker.elastic.co/elasticsearch/elasticsearch:7.10.2

ARG ELASTICSEARCH_VERSION=7.10.2
ARG LOG4J_VERSION=2.16.0

RUN set -eux; \
    yum install -y \
        wget; \
    # analysis-ik
    wget -qO "/tmp/elasticsearch-analysis-ik-${ELASTICSEARCH_VERSION}.zip" \
        "https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v${ELASTICSEARCH_VERSION}/elasticsearch-analysis-ik-${ELASTICSEARCH_VERSION}.zip"; \
    bin/elasticsearch-plugin install --batch file:///tmp/elasticsearch-analysis-ik-${ELASTICSEARCH_VERSION}.zip; \
    rm -r /tmp/*;

# security
RUN set -eux; \
    # https://logging.apache.org/log4j/2.x/security.html
    rm -f /usr/share/elasticsearch/lib/log4j*; \
    wget -qO "/usr/share/elasticsearch/lib/log4j-api-${LOG4J_VERSION}.jar" "https://maven.aliyun.com/repository/public/org/apache/logging/log4j/log4j-api/${LOG4J_VERSION}/log4j-api-${LOG4J_VERSION}.jar"; \
    wget -qO "/usr/share/elasticsearch/lib/log4j-core-${LOG4J_VERSION}.jar" "https://maven.aliyun.com/repository/public/org/apache/logging/log4j/log4j-core/${LOG4J_VERSION}/log4j-core-${LOG4J_VERSION}.jar"
