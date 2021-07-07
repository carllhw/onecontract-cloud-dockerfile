FROM docker.elastic.co/elasticsearch/elasticsearch:7.10.2

ARG ELASTICSEARCH_VERSION=7.10.2

RUN set -eux; \
    yum install -y \
    wget; \
    # analysis-ik
    wget -qO "/tmp/elasticsearch-analysis-ik-${ELASTICSEARCH_VERSION}.zip" \
    "https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v${ELASTICSEARCH_VERSION}/elasticsearch-analysis-ik-${ELASTICSEARCH_VERSION}.zip"; \
    bin/elasticsearch-plugin install --batch file:///tmp/elasticsearch-analysis-ik-${ELASTICSEARCH_VERSION}.zip; \
    rm -r /tmp/*;
