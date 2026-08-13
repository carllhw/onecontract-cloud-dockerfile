ARG ELASTICSEARCH_VERSION=7.17.29
FROM docker.elastic.co/elasticsearch/elasticsearch:${ELASTICSEARCH_VERSION}

ARG ELASTICSEARCH_VERSION

RUN set -eux; \
    # analysis-ik
    curl -LfsSo "/tmp/elasticsearch-analysis-ik-${ELASTICSEARCH_VERSION}.zip" \
        "https://release.infinilabs.com/analysis-ik/stable/elasticsearch-analysis-ik-${ELASTICSEARCH_VERSION}.zip"; \
    bin/elasticsearch-plugin install --batch file:///tmp/elasticsearch-analysis-ik-${ELASTICSEARCH_VERSION}.zip; \
    rm -r /tmp/*;
