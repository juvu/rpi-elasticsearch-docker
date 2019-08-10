ARG BALENA_MACHINE_NAME="raspberry-pi2"
FROM balenalib/${BALENA_MACHINE_NAME}-openjdk

RUN [ "cross-build-start" ]

ARG ELASTICSEARCH_VERSION="7.3.0"
RUN curl -o elasticsearch-${ELASTICSEARCH_VERSION}-linux-x86_64.tar.gz https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ELASTICSEARCH_VERSION}-linux-x86_64.tar.gz \
    && tar zxvf elasticsearch-${ELASTICSEARCH_VERSION}-linux-x86_64.tar.gz

WORKDIR /elasticsearch-${ELASTICSEARCH_VERSION}

RUN echo "network.host: 0.0.0.0" >>config/elasticsearch.yml \
    && echo "discovery.type: single-node" >>config/elasticsearch.yml \
    && echo "xpack.ml.enabled: false" >>config/elasticsearch.yml \
    && sed -e "s/Xms1g/Xms256m/" -i config/jvm.options \
    && sed -e "s/Xmx1g/Xmx256m/" -i config/jvm.options

RUN [ "cross-build-end" ]

ENTRYPOINT [ "bin/elasticsearch" ]
