FROM maven:3.9.3-eclipse-temurin-17-alpine

LABEL "org.opencontainers.image.title"="karavan"
LABEL "org.opencontainers.image.description"="Apache Camel Karavan DevMode"
LABEL "org.opencontainers.image.url"="https://camel.apache.org"
LABEL "org.opencontainers.image.licenses"="Apache 2.0"
LABEL "org.opencontainers.image.version"="4.0.0-RC2"

ENV JBANG_VERSION=0.110.0
ENV CAMEL_VERSION=4.0.0-RC2
ENV KARAVAN="/karavan"
ENV JBANG_REPO="$KARAVAN/.jbang/cache/.m2"
ENV JBANG_DIR="$KARAVAN/.jbang"
ENV MAVEN_SETTINGS="/karavan-config-map/maven-settings.xml"
ENV KAMELETS_DIR="/scripts/kamelets"
ENV CHECKOUT_DIR="/scripts"
ENV CODE_DIR="/code"
ENV PATH="${PATH}:$KARAVAN/.jbang/bin"

RUN curl -Ls https://sh.jbang.dev | bash -s - app setup \
    && apk update && apk add git \
    && mkdir -p $CODE_DIR \
    && jbang trust add  --quiet  https://github.com/apache/camel \
    && jbang app install camel@apache/camel

EXPOSE 8080

ENTRYPOINT ["jbang"]