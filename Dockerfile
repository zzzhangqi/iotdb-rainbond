FROM openjdk:8-jdk-alpine
ARG VERSION=0.13.2

RUN apk add --no-cache wget unzip lsof procps net-tools bash bind-tools \
    && wget https://archive.apache.org/dist/iotdb/$VERSION/apache-iotdb-$VERSION-all-bin.zip \
    && unzip apache-iotdb-$VERSION-all-bin.zip \
    && rm apache-iotdb-$VERSION-all-bin.zip \
    && mv apache-iotdb-$VERSION-all-bin /iotdb

COPY iotdb-cluster.properties /iotdb/conf/iotdb-cluster.properties
COPY iotdb-engine.properties /iotdb/conf/iotdb-engine.properties
COPY iotdb-env.sh /iotdb/conf/iotdb-env.sh

ENV IOTDB_CONF=/iotdb/conf
WORKDIR /iotdb

EXPOSE 6667 31999 8181

CMD ["/bin/bash", "/iotdb/sbin/start-node.sh"]