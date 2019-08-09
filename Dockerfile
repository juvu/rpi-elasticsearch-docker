FROM balenalib/raspberry-pi2-openjdk

RUN [ "cross-build-start" ]

ARG ELASTICSEARCH_VERSION="7.3.0"
RUN curl -o elasticsearch-${ELASTICSEARCH_VERSION}-linux-x86_64.tar.gz https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ELASTICSEARCH_VERSION}-linux-x86_64.tar.gz \
    && tar zxvf elasticsearch-${ELASTICSEARCH_VERSION}-linux-x86_64.tar.gz

WORKDIR /elasticsearch-${ELASTICSEARCH_VERSION}

RUN [ "cross-build-end" ]

ENTRYPOINT [ "bin/elasticsearch" ]
